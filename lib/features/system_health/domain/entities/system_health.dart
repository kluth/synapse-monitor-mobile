import 'package:equatable/equatable.dart';

import 'alert.dart';

/// Entity representing overall system health.
///
/// Provides an aggregate view of system health including health score,
/// component counts, and active alerts.
class SystemHealth extends Equatable {
  const SystemHealth({
    required this.overallScore,
    required this.healthyComponents,
    required this.totalComponents,
    required this.alerts,
    required this.timestamp,
    this.unhealthyComponents,
    this.componentBreakdown,
  });

  /// Overall health score (0-100)
  final double overallScore;

  /// Number of healthy components
  final int healthyComponents;

  /// Total number of components in the system
  final int totalComponents;

  /// List of active alerts
  final List<Alert> alerts;

  /// When this health snapshot was taken
  final DateTime timestamp;

  /// Number of unhealthy components (optional, can be calculated)
  final int? unhealthyComponents;

  /// Breakdown of health by component type (optional)
  final Map<String, ComponentHealthInfo>? componentBreakdown;

  /// Calculate unhealthy component count
  int get calculatedUnhealthyComponents {
    return unhealthyComponents ?? (totalComponents - healthyComponents);
  }

  /// Calculate health percentage
  double get healthPercentage {
    if (totalComponents == 0) {
      return 100.0;
    }
    return (healthyComponents / totalComponents) * 100;
  }

  /// Check if system health is critical (score < 50)
  bool get isCritical => overallScore < 50.0;

  /// Check if system health has warnings (score < 70)
  bool get hasWarnings => overallScore >= 50.0 && overallScore < 70.0;

  /// Check if system health is good (score >= 70)
  bool get isHealthy => overallScore >= 70.0;

  /// Check if system health is excellent (score >= 90)
  bool get isExcellent => overallScore >= 90.0;

  /// Get active alerts
  List<Alert> get activeAlerts {
    return alerts.where((alert) => alert.isActive).toList();
  }

  /// Get critical alerts
  List<Alert> get criticalAlerts {
    return activeAlerts.where((alert) => alert.isCritical).toList();
  }

  /// Get warning alerts
  List<Alert> get warningAlerts {
    return activeAlerts.where((alert) => alert.isWarning).toList();
  }

  /// Check if there are any critical alerts
  bool get hasCriticalAlerts => criticalAlerts.isNotEmpty;

  /// Get alert count by severity
  Map<String, int> get alertCountBySeverity {
    final counts = <String, int>{
      'critical': 0,
      'warning': 0,
      'info': 0,
    };

    for (final alert in activeAlerts) {
      counts[alert.severity] = (counts[alert.severity] ?? 0) + 1;
    }

    return counts;
  }

  @override
  List<Object?> get props => [
        overallScore,
        healthyComponents,
        totalComponents,
        alerts,
        timestamp,
        unhealthyComponents,
        componentBreakdown,
      ];

  @override
  String toString() => 'SystemHealth(score: ${overallScore.toStringAsFixed(1)}, '
      'components: $healthyComponents/$totalComponents, alerts: ${activeAlerts.length})';
}

/// Value object for component health information.
class ComponentHealthInfo extends Equatable {
  const ComponentHealthInfo({
    required this.type,
    required this.healthy,
    required this.total,
    this.healthScore,
  });

  /// Type of component (e.g., 'neurons', 'synapses', 'glial_cells')
  final String type;

  /// Number of healthy components of this type
  final int healthy;

  /// Total number of components of this type
  final int total;

  /// Health score for this component type (optional)
  final double? healthScore;

  /// Calculate health percentage
  double get healthPercentage {
    if (total == 0) {
      return 100.0;
    }
    return (healthy / total) * 100;
  }

  @override
  List<Object?> get props => [type, healthy, total, healthScore];

  @override
  String toString() => 'ComponentHealthInfo(type: $type, $healthy/$total)';
}
