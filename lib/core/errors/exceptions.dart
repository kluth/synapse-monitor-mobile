/// Custom exceptions for the Synapse Monitor application.
///
/// These exceptions are thrown in the data layer and are converted to
/// [Failure] objects in the repository layer.

/// Base exception class for all custom exceptions
abstract class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Exception thrown when a server error occurs (5xx)
class ServerException extends AppException {
  const ServerException([super.message = 'Server error occurred']);
}

/// Exception thrown when a network error occurs (connectivity issues)
class NetworkException extends AppException {
  const NetworkException([
    super.message = 'Network connection failed. Please check your connection.',
  ]);
}

/// Exception thrown when authentication fails (401)
class UnauthorizedException extends AppException {
  const UnauthorizedException([
    super.message = 'Unauthorized access. Please check your credentials.',
  ]);
}

/// Exception thrown when access is forbidden (403)
class ForbiddenException extends AppException {
  const ForbiddenException([
    super.message = 'Access forbidden. You do not have permission.',
  ]);
}

/// Exception thrown when a resource is not found (404)
class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Resource not found']);
}

/// Exception thrown when a bad request occurs (400)
class BadRequestException extends AppException {
  const BadRequestException([super.message = 'Bad request']);
}

/// Exception thrown when a request timeout occurs
class TimeoutException extends AppException {
  const TimeoutException([
    super.message = 'Request timed out. Please try again.',
  ]);
}

/// Exception thrown when data parsing fails
class ParseException extends AppException {
  const ParseException([
    super.message = 'Failed to parse response data',
  ]);
}

/// Exception thrown when cache operations fail
class CacheException extends AppException {
  const CacheException([super.message = 'Cache operation failed']);
}

/// Exception thrown when WebSocket connection fails
class WebSocketException extends AppException {
  const WebSocketException([
    super.message = 'WebSocket connection failed',
  ]);
}

/// Exception thrown when WebSocket connection is closed unexpectedly
class WebSocketClosedException extends AppException {
  const WebSocketClosedException([
    super.message = 'WebSocket connection closed',
  ]);
}

/// Exception thrown when validation fails
class ValidationException extends AppException {
  const ValidationException([super.message = 'Validation failed']);
}

/// Exception thrown for unknown errors
class UnknownException extends AppException {
  const UnknownException([
    super.message = 'An unexpected error occurred',
  ]);
}

/// Exception thrown when data is not available in cache
class CacheMissException extends AppException {
  const CacheMissException([super.message = 'Data not found in cache']);
}

/// Exception thrown when a feature is not implemented
class NotImplementedException extends AppException {
  const NotImplementedException([
    super.message = 'Feature not yet implemented',
  ]);
}
