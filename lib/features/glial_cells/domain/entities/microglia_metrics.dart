import 'package:equatable/equatable.dart';

import '../../../system_health/domain/entities/alert.dart';

/// Entity representing Microglia (health monitoring) metrics.
///
/// Microglia track system health through error monitoring, custom metrics,
/// health checks, and alert generation. They provide aggregate health
/// assessment and track threshold breaches.
class MicrogliaMetrics extends Equatable {
  const MicrogliaMetrics({
    required this.errorCounts,
    required this.errorRate,
    required this.customMetrics,
    required this.healthChecks,
    required this.alertHistory,
    required this.systemHealthScore,
    required this.thresholdBreaches,
    this.monitoredServices,
    this.timestamp,
  });

  /// Error counts per service/component
  final Map<String, int> errorCounts;

  /// Current error rate (errors per minute)
  final double errorRate;

  /// Custom metrics collected from services
  final Map<String, double> customMetrics;

  /// Health check results for each service (true = healthy, false = unhealthy)
  final Map<String, bool> healthChecks;

  /// History of recent alerts
  final List<Alert> alertHistory;

  /// Overall system health score (0-100)
  final double systemHealthScore;

  /// Number of times thresholds have been breached
  final int thresholdBreaches;

  /// List of services being monitored (optional)
  final List<String>? monitoredServices;

  /// Timestamp when metrics were collected (optional)
  final DateTime? timestamp;

  /// Get total error count across all services
  int get totalErrors {
    return errorCounts.values.fold<int>(0, (sum, count) => sum + count);
  }

  /// Get number of healthy services
  int get healthyServicesCount {
    return healthChecks.values.where((isHealthy) => isHealthy).length;
  }

  /// Get number of unhealthy services
  int get unhealthyServicesCount {
    return healthChecks.values.where((isHealthy) => !isHealthy).length;
  }

  /// Get total number of monitored services
  int get totalServicesCount => healthChecks.length;

  /// Calculate service health percentage
  double get serviceHealthPercentage {
    if (totalServicesCount == 0) {
      return 100.0;
    }
    return (healthyServicesCount / totalServicesCount) * 100;
  }

  /// Check if system health is critical (score < 50)
  bool get isCriticalHealth => systemHealthScore < 50.0;

  /// Check if system health is warning (score < 70)
  bool get isWarningHealth => systemHealthScore >= 50.0 && systemHealthScore < 70.0;

  /// Check if system health is good (score >= 70)
  bool get isGoodHealth => systemHealthScore >= 70.0;

  /// Check if error rate is high (>10 errors/min)
  bool get hasHighErrorRate => errorRate > 10.0;

  /// Get active alerts (not acknowledged)
  List<Alert> get activeAlerts {
    return alertHistory.where((alert) => alert.isActive).toList();
  }

  /// Get critical alerts
  List<Alert> get criticalAlerts {
    return activeAlerts.where((alert) => alert.isCritical).toList();
  }

  /// Get service with most errors
  String? get mostErroredService {
    if (errorCounts.isEmpty) {
      return null;
    }

    return errorCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  /// Check if there are any unhealthy services
  bool get hasUnhealthyServices => unhealthyServicesCount > 0;

  /// Check if there are recent threshold breaches
  bool get hasRecentBreaches => thresholdBreaches > 0;

  @override
  List<Object?> get props => [
        errorCounts,
        errorRate,
        customMetrics,
        healthChecks,
        alertHistory,
        systemHealthScore,
        thresholdBreaches,
        monitoredServices,
        timestamp,
      ];

  @override
  String toString() => 'MicrogliaMetrics(healthScore: ${systemHealthScore.toStringAsFixed(1)}, '
      'errorRate: ${errorRate.toStringAsFixed(2)}/min, alerts: ${activeAlerts.length})';
}
