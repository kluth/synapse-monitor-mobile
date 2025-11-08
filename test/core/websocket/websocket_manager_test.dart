import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:synapse_monitor/core/websocket/websocket_manager.dart';

class MockWebSocketChannel extends Mock implements WebSocketChannel {}

/// 🔴 RED PHASE - WebSocketManager Tests

void main() {
  late WebSocketManager manager;
  late MockWebSocketChannel mockChannel;

  setUp(() {
    mockChannel = MockWebSocketChannel();
    manager = WebSocketManager(url: 'ws://localhost:8080');
  });

  group('WebSocketManager', () {
    group('connect', () {
      test('should establish WebSocket connection', () async {
        // This test will FAIL

        await manager.connect();

        expect(manager.isConnected, true);
        expect(manager.connectionState, ConnectionState.connected);
      });

      test('should throw exception when connection fails', () async {
        // This test will FAIL

        await expectLater(
          () => manager.connect(url: 'ws://invalid-url'),
          throwsA(isA<WebSocketException>()),
        );
      });

      test('should not connect if already connected', () async {
        // This test will FAIL

        await manager.connect();
        await manager.connect(); // Second call should be no-op

        expect(manager.isConnected, true);
      });
    });

    group('disconnect', () {
      test('should close WebSocket connection', () async {
        // This test will FAIL

        await manager.connect();
        await manager.disconnect();

        expect(manager.isConnected, false);
        expect(manager.connectionState, ConnectionState.disconnected);
      });

      test('should handle disconnect when not connected', () async {
        // This test will FAIL

        await manager.disconnect(); // Should not throw

        expect(manager.isConnected, false);
      });
    });

    group('send', () {
      test('should send message through WebSocket', () async {
        // This test will FAIL

        await manager.connect();

        final message = {'type': 'subscribe', 'channel': 'neurons'};
        manager.send(message);

        verify(() => mockChannel.sink.add(any())).called(1);
      });

      test('should throw exception when not connected', () async {
        // This test will FAIL

        expect(
          () => manager.send({'test': 'data'}),
          throwsA(isA<StateError>()),
        );
      });

      test('should queue messages when connection is establishing', () async {
        // This test will FAIL

        manager.connect(); // Don't await
        manager.send({'test': 'data'});

        // Message should be queued and sent after connection established
        await Future.delayed(const Duration(milliseconds: 100));
        expect(manager.messageQueue, isEmpty);
      });
    });

    group('stream', () {
      test('should provide stream of incoming messages', () async {
        // This test will FAIL

        await manager.connect();

        final testMessages = [
          {'type': 'neuron_update', 'id': 'neuron-1'},
          {'type': 'synapse_update', 'id': 'synapse-1'},
        ];

        final stream = Stream.fromIterable(testMessages);
        when(() => mockChannel.stream).thenAnswer((_) => stream);

        await expectLater(
          manager.stream,
          emitsInOrder(testMessages),
        );
      });

      test('should handle stream errors', () async {
        // This test will FAIL

        await manager.connect();

        when(() => mockChannel.stream)
            .thenAnswer((_) => Stream.error(Exception('Stream error')));

        await expectLater(
          manager.stream,
          emitsError(isA<Exception>()),
        );
      });
    });

    group('reconnect', () {
      test('should attempt reconnection on connection lost', () async {
        // This test will FAIL

        await manager.connect();
        manager.onConnectionLost(); // Simulate connection loss

        await Future.delayed(manager.reconnectDelay);

        expect(manager.reconnectAttempts, greaterThan(0));
      });

      test('should use exponential backoff for reconnection', () async {
        // This test will FAIL

        manager.reconnectAttempts = 3;
        final delay = manager.calculateReconnectDelay();

        expect(delay.inSeconds, greaterThan(manager.reconnectDelay.inSeconds));
      });

      test('should stop reconnecting after max attempts', () async {
        // This test will FAIL

        manager.maxReconnectAttempts = 3;
        manager.reconnectAttempts = 4;

        await manager.attemptReconnect();

        expect(manager.connectionState, ConnectionState.failed);
      });
    });

    group('ping/pong', () {
      test('should send periodic ping messages', () async {
        // This test will FAIL

        await manager.connect();
        manager.startPingTimer();

        await Future.delayed(manager.pingInterval + const Duration(seconds: 1));

        verify(() => mockChannel.sink.add(any())).called(greaterThan(0));
      });

      test('should detect connection timeout on missing pong', () async {
        // This test will FAIL

        await manager.connect();
        manager.startPingTimer();

        // Don't send pong response
        await Future.delayed(manager.pongTimeout);

        expect(manager.connectionState, ConnectionState.disconnected);
      });
    });

    group('subscriptions', () {
      test('should subscribe to specific channels', () async {
        // This test will FAIL

        await manager.connect();
        manager.subscribe('neurons');

        expect(manager.subscriptions, contains('neurons'));
      });

      test('should unsubscribe from channels', () async {
        // This test will FAIL

        await manager.connect();
        manager.subscribe('neurons');
        manager.unsubscribe('neurons');

        expect(manager.subscriptions, isNot(contains('neurons')));
      });

      test('should send subscription message to server', () async {
        // This test will FAIL

        await manager.connect();
        manager.subscribe('neurons');

        verify(() => mockChannel.sink.add(argThat(
          contains('subscribe'),
        ))).called(1);
      });
    });

    group('error handling', () {
      test('should handle malformed messages gracefully', () async {
        // This test will FAIL

        await manager.connect();

        final invalidMessage = 'invalid-json';
        manager.handleMessage(invalidMessage);

        expect(manager.lastError, isA<FormatException>());
      });

      test('should emit error events', () async {
        // This test will FAIL

        await manager.connect();

        await expectLater(
          manager.errorStream,
          emits(isA<WebSocketException>()),
        );

        manager.emitError(WebSocketException('Test error'));
      });
    });

    group('cleanup', () {
      test('should clean up resources on dispose', () async {
        // This test will FAIL

        await manager.connect();
        manager.dispose();

        expect(manager.isDisposed, true);
        expect(manager.isConnected, false);
      });

      test('should cancel all subscriptions on dispose', () async {
        // This test will FAIL

        await manager.connect();
        manager.subscribe('neurons');
        manager.subscribe('synapses');

        manager.dispose();

        expect(manager.subscriptions, isEmpty);
      });
    });
  });
}
