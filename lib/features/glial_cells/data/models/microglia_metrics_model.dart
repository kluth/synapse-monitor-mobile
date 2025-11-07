import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../system_health/data/models/alert_model.dart';
import '../../domain/entities/microglia_metrics.dart';

part 'microglia_metrics_model.freezed.dart';
part 'microglia_metrics_model.g.dart';

/// Data model for [MicrogliaMetrics] with JSON serialization support.
@freezed
class MicrogliaMetricsModel with _$MicrogliaMetricsModel {
  const factory MicrogliaMetricsModel({
    required Map<String, int> errorCounts,
    required double errorRate,
    required Map<String, double> customMetrics,
    required Map<String, bool> healthChecks,
    required List<AlertModel> alertHistory,
    required double systemHealthScore,
    required int thresholdBreaches,
    List<String>? monitoredServices,
    DateTime? timestamp,
  }) = _MicrogliaMetricsModel;

  const MicrogliaMetricsModel._();

  /// Create model from JSON
  factory MicrogliaMetricsModel.fromJson(Map<String, dynamic> json) =>
      _$MicrogliaMetricsModelFromJson(json);

  /// Convert model to domain entity
  MicrogliaMetrics toEntity() {
    return MicrogliaMetrics(
      errorCounts: errorCounts,
      errorRate: errorRate,
      customMetrics: customMetrics,
      healthChecks: healthChecks,
      alertHistory: alertHistory.map((model) => model.toEntity()).toList(),
      systemHealthScore: systemHealthScore,
      thresholdBreaches: thresholdBreaches,
      monitoredServices: monitoredServices,
      timestamp: timestamp,
    );
  }

  /// Create model from domain entity
  factory MicrogliaMetricsModel.fromEntity(MicrogliaMetrics entity) {
    return MicrogliaMetricsModel(
      errorCounts: entity.errorCounts,
      errorRate: entity.errorRate,
      customMetrics: entity.customMetrics,
      healthChecks: entity.healthChecks,
      alertHistory: entity.alertHistory
          .map((alert) => AlertModel.fromEntity(alert))
          .toList(),
      systemHealthScore: entity.systemHealthScore,
      thresholdBreaches: entity.thresholdBreaches,
      monitoredServices: entity.monitoredServices,
      timestamp: entity.timestamp,
    );
  }
}
