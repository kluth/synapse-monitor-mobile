import 'package:equatable/equatable.dart';

/// Base class for all failures in the application.
///
/// Failures represent errors at the domain/use case level and are
/// used to communicate errors from repositories to the presentation layer.
abstract class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message;
}

/// Failure that occurs when a server error happens (5xx)
class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'Server error occurred. Please try again later.',
  ]);
}

/// Failure that occurs when a network error happens
class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'Network connection failed. Please check your connection.',
  ]);
}

/// Failure that occurs when authentication fails
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    super.message = 'Unauthorized access. Please check your credentials.',
  ]);
}

/// Failure that occurs when access is forbidden
class ForbiddenFailure extends Failure {
  const ForbiddenFailure([
    super.message = 'Access forbidden. You do not have permission.',
  ]);
}

/// Failure that occurs when a resource is not found
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Resource not found']);
}

/// Failure that occurs when a bad request is made
class BadRequestFailure extends Failure {
  const BadRequestFailure([super.message = 'Invalid request']);
}

/// Failure that occurs when a request times out
class TimeoutFailure extends Failure {
  const TimeoutFailure([
    super.message = 'Request timed out. Please try again.',
  ]);
}

/// Failure that occurs when data parsing fails
class ParseFailure extends Failure {
  const ParseFailure([
    super.message = 'Failed to parse response data',
  ]);
}

/// Failure that occurs when cache operations fail
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache operation failed']);
}

/// Failure that occurs when WebSocket connection fails
class WebSocketFailure extends Failure {
  const WebSocketFailure([
    super.message = 'WebSocket connection failed',
  ]);
}

/// Failure that occurs when validation fails
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failed']);

  /// Constructor with field-specific errors
  const ValidationFailure.withErrors(
    String message,
    this.errors,
  ) : super(message);

  final Map<String, String>? errors;

  @override
  List<Object?> get props => [message, errors];
}

/// Failure that occurs for unknown errors
class UnknownFailure extends Failure {
  const UnknownFailure([
    super.message = 'An unexpected error occurred',
  ]);
}

/// Failure that occurs when a feature is not implemented
class NotImplementedFailure extends Failure {
  const NotImplementedFailure([
    super.message = 'Feature not yet implemented',
  ]);
}
