import 'package:equatable/equatable.dart';

/// Entity representing a system alert.
///
/// Alerts are triggered when error thresholds are exceeded or
/// critical system events occur. They can be critical, warning, or info.
class Alert extends Equatable {
  const Alert({
    required this.id,
    required this.severity,
    required this.message,
    required this.source,
    required this.timestamp,
    required this.isActive,
    this.acknowledgedAt,
    this.acknowledgedBy,
    this.metadata,
  });

  /// Unique identifier for the alert
  final String id;

  /// Severity level: 'critical', 'warning', or 'info'
  final String severity;

  /// Alert message describing the issue
  final String message;

  /// Source component that triggered the alert
  final String source;

  /// When the alert was created
  final DateTime timestamp;

  /// Whether the alert is currently active
  final bool isActive;

  /// When the alert was acknowledged (optional)
  final DateTime? acknowledgedAt;

  /// Who acknowledged the alert (optional)
  final String? acknowledgedBy;

  /// Additional metadata about the alert (optional)
  final Map<String, dynamic>? metadata;

  /// Check if alert is critical
  bool get isCritical => severity == 'critical';

  /// Check if alert is a warning
  bool get isWarning => severity == 'warning';

  /// Check if alert is informational
  bool get isInfo => severity == 'info';

  /// Check if alert has been acknowledged
  bool get isAcknowledged => acknowledgedAt != null;

  /// Check if alert is recent (less than 1 hour old)
  bool get isRecent {
    final now = DateTime.now();
    final oneHourAgo = now.subtract(const Duration(hours: 1));
    return timestamp.isAfter(oneHourAgo);
  }

  /// Get alert age
  Duration get age {
    return DateTime.now().difference(timestamp);
  }

  @override
  List<Object?> get props => [
        id,
        severity,
        message,
        source,
        timestamp,
        isActive,
        acknowledgedAt,
        acknowledgedBy,
        metadata,
      ];

  @override
  String toString() => 'Alert(id: $id, severity: $severity, '
      'source: $source, active: $isActive)';
}
