import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

/// Application-wide logging utility.
///
/// Provides structured logging with different levels:
/// - debug: Development debugging information
/// - info: General informational messages
/// - warning: Warning messages for potential issues
/// - error: Error messages for failures
///
/// Logging is conditional based on debug mode and environment configuration.
class AppLogger {
  AppLogger() {
    _isDebugLoggingEnabled = _checkDebugLogging();
  }

  late final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
    level: _isDebugLoggingEnabled ? Level.debug : Level.warning,
  );

  late final bool _isDebugLoggingEnabled;

  bool _checkDebugLogging() {
    // Check environment variable
    final envDebug = dotenv.env['ENABLE_DEBUG_LOGGING'];
    if (envDebug != null) {
      return envDebug.toLowerCase() == 'true';
    }

    // Default to debug mode in development
    return kDebugMode;
  }

  /// Log a debug message
  ///
  /// Only shown in debug builds or when debug logging is enabled
  void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    if (_isDebugLoggingEnabled) {
      _logger.d(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Log an informational message
  void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log a warning message
  void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log an error message
  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log a fatal error message
  void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  /// Log network request
  void logRequest(String method, String url, {Map<String, dynamic>? headers}) {
    if (_isDebugLoggingEnabled) {
      debug('→ $method $url');
      if (headers != null && headers.isNotEmpty) {
        debug('  Headers: $headers');
      }
    }
  }

  /// Log network response
  void logResponse(int statusCode, String url, {dynamic data}) {
    if (_isDebugLoggingEnabled) {
      debug('← $statusCode $url');
      if (data != null) {
        debug('  Response: $data');
      }
    }
  }

  /// Log WebSocket event
  void logWebSocket(String event, {dynamic data}) {
    if (_isDebugLoggingEnabled) {
      debug('⚡ WebSocket: $event');
      if (data != null) {
        debug('  Data: $data');
      }
    }
  }

  /// Close the logger
  void close() {
    _logger.close();
  }
}
