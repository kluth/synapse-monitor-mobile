import 'package:equatable/equatable.dart';

/// Entity representing an error log entry.
///
/// Captures detailed information about errors that occur in the system,
/// including service name, error details, stack trace, and context.
class ErrorLog extends Equatable {
  const ErrorLog({
    required this.id,
    required this.serviceName,
    required this.error,
    required this.timestamp,
    this.stackTrace,
    this.context,
    this.severity,
    this.resolved,
    this.resolvedAt,
  });

  /// Unique identifier for the error log
  final String id;

  /// Name of the service/component where the error occurred
  final String serviceName;

  /// Error message or description
  final String error;

  /// When the error occurred
  final DateTime timestamp;

  /// Stack trace of the error (optional)
  final String? stackTrace;

  /// Additional context information (optional)
  final Map<String, dynamic>? context;

  /// Severity level of the error (optional)
  final String? severity;

  /// Whether the error has been resolved
  final bool? resolved;

  /// When the error was resolved (optional)
  final DateTime? resolvedAt;

  /// Check if error is recent (within last hour)
  bool get isRecent {
    final now = DateTime.now();
    final oneHourAgo = now.subtract(const Duration(hours: 1));
    return timestamp.isAfter(oneHourAgo);
  }

  /// Check if error has stack trace
  bool get hasStackTrace => stackTrace != null && stackTrace!.isNotEmpty;

  /// Check if error has context
  bool get hasContext => context != null && context!.isNotEmpty;

  /// Check if error is resolved
  bool get isResolved => resolved == true;

  /// Get error age
  Duration get age {
    return DateTime.now().difference(timestamp);
  }

  /// Get resolution time if resolved
  Duration? get resolutionTime {
    if (!isResolved || resolvedAt == null) {
      return null;
    }
    return resolvedAt!.difference(timestamp);
  }

  @override
  List<Object?> get props => [
        id,
        serviceName,
        error,
        timestamp,
        stackTrace,
        context,
        severity,
        resolved,
        resolvedAt,
      ];

  @override
  String toString() => 'ErrorLog(id: $id, service: $serviceName, '
      'error: ${error.length > 50 ? '${error.substring(0, 50)}...' : error})';
}
