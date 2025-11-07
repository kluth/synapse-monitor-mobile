import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../constants/api_constants.dart';
import '../errors/exceptions.dart';
import '../utils/logger.dart';

/// WebSocket client with auto-reconnection and event handling.
///
/// Features:
/// - Automatic reconnection with exponential backoff
/// - Heartbeat/ping-pong mechanism
/// - Event-based message routing
/// - Connection state management
/// - Error recovery
class WebSocketClient {
  WebSocketClient({
    AppLogger? logger,
    String? url,
  })  : _logger = logger ?? AppLogger(),
        _url = url ??
            dotenv.env['SYNAPSE_API_ENDPOINT'] ??
            ApiConstants.defaultWebSocketUrl;

  final AppLogger _logger;
  final String _url;

  WebSocketChannel? _channel;
  Timer? _reconnectTimer;
  Timer? _pingTimer;
  int _reconnectAttempts = 0;

  final _connectionStateController = StreamController<ConnectionState>.broadcast();
  final _eventControllers = <String, StreamController<dynamic>>{};

  ConnectionState _state = ConnectionState.disconnected;

  /// Current connection state
  ConnectionState get state => _state;

  /// Stream of connection state changes
  Stream<ConnectionState> get connectionState => _connectionStateController.stream;

  /// Connect to the WebSocket server
  Future<void> connect() async {
    if (_state == ConnectionState.connected ||
        _state == ConnectionState.connecting) {
      _logger.warning('WebSocket already connected or connecting');
      return;
    }

    _updateState(ConnectionState.connecting);

    try {
      _logger.info('Connecting to WebSocket: $_url');

      _channel = WebSocketChannel.connect(Uri.parse(_url));

      // Wait for connection to establish
      await _channel!.ready;

      _reconnectAttempts = 0;
      _updateState(ConnectionState.connected);
      _logger.info('WebSocket connected successfully');

      // Start listening to messages
      _listenToMessages();

      // Start ping/pong heartbeat
      _startHeartbeat();
    } catch (e, stackTrace) {
      _logger.error('WebSocket connection failed', e, stackTrace);
      _updateState(ConnectionState.error);
      _scheduleReconnect();
      throw const WebSocketException('Failed to connect to WebSocket');
    }
  }

  /// Disconnect from the WebSocket server
  Future<void> disconnect() async {
    _logger.info('Disconnecting WebSocket');

    _reconnectTimer?.cancel();
    _pingTimer?.cancel();

    await _channel?.sink.close();
    _channel = null;

    _updateState(ConnectionState.disconnected);
    _logger.info('WebSocket disconnected');
  }

  /// Listen to a specific event
  Stream<dynamic> listen(String event) {
    if (!_eventControllers.containsKey(event)) {
      _eventControllers[event] = StreamController<dynamic>.broadcast();
    }
    return _eventControllers[event]!.stream;
  }

  /// Send a message to the server
  void send(String event, [Map<String, dynamic>? data]) {
    if (_state != ConnectionState.connected) {
      throw const WebSocketException('WebSocket is not connected');
    }

    final message = jsonEncode({
      'event': event,
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    });

    _logger.logWebSocket('Sending: $event', data: data);
    _channel?.sink.add(message);
  }

  void _listenToMessages() {
    _channel?.stream.listen(
      (dynamic message) {
        _handleMessage(message);
      },
      onError: (dynamic error) {
        _logger.error('WebSocket error', error);
        _updateState(ConnectionState.error);
        _scheduleReconnect();
      },
      onDone: () {
        _logger.warning('WebSocket connection closed');
        if (_state != ConnectionState.disconnected) {
          _updateState(ConnectionState.disconnected);
          _scheduleReconnect();
        }
      },
      cancelOnError: false,
    );
  }

  void _handleMessage(dynamic message) {
    try {
      final data = jsonDecode(message as String) as Map<String, dynamic>;
      final event = data['event'] as String?;

      if (event == null) {
        _logger.warning('Received message without event type');
        return;
      }

      // Handle pong response
      if (event == 'pong') {
        return;
      }

      _logger.logWebSocket('Received: $event', data: data['data']);

      // Route to event-specific stream
      if (_eventControllers.containsKey(event)) {
        _eventControllers[event]!.add(data['data']);
      }
    } catch (e, stackTrace) {
      _logger.error('Failed to parse WebSocket message', e, stackTrace);
    }
  }

  void _startHeartbeat() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(
      ApiConstants.wsPingInterval,
      (_) {
        if (_state == ConnectionState.connected) {
          try {
            send('ping');
          } catch (e) {
            _logger.error('Failed to send ping', e);
          }
        }
      },
    );
  }

  void _scheduleReconnect() {
    if (_reconnectAttempts >= ApiConstants.wsMaxReconnectAttempts) {
      _logger.error(
        'Max reconnection attempts reached (${ApiConstants.wsMaxReconnectAttempts})',
      );
      _updateState(ConnectionState.disconnected);
      return;
    }

    _reconnectAttempts++;

    // Calculate delay with exponential backoff
    final delay = ApiConstants.wsReconnectInterval *
        (1 << (_reconnectAttempts - 1).clamp(0, 5)); // Max 32x delay

    _logger.info(
      'Scheduling reconnection attempt $_reconnectAttempts in $delay',
    );

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      if (_state != ConnectionState.connected) {
        connect();
      }
    });
  }

  void _updateState(ConnectionState newState) {
    if (_state != newState) {
      _state = newState;
      _connectionStateController.add(newState);
      _logger.info('WebSocket state changed to: $newState');
    }
  }

  /// Dispose resources
  Future<void> dispose() async {
    await disconnect();
    await _connectionStateController.close();

    for (final controller in _eventControllers.values) {
      await controller.close();
    }
    _eventControllers.clear();
  }
}

/// WebSocket connection state
enum ConnectionState {
  /// Not connected
  disconnected,

  /// Attempting to connect
  connecting,

  /// Successfully connected
  connected,

  /// Connection error occurred
  error,
}
