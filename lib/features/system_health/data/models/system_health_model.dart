import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/system_health.dart';
import 'alert_model.dart';

part 'system_health_model.freezed.dart';
part 'system_health_model.g.dart';

/// Data model for [ComponentHealthInfo] with JSON serialization support.
@freezed
class ComponentHealthInfoModel with _$ComponentHealthInfoModel {
  const factory ComponentHealthInfoModel({
    required String type,
    required int healthy,
    required int total,
    double? healthScore,
  }) = _ComponentHealthInfoModel;

  const ComponentHealthInfoModel._();

  factory ComponentHealthInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ComponentHealthInfoModelFromJson(json);

  ComponentHealthInfo toEntity() {
    return ComponentHealthInfo(
      type: type,
      healthy: healthy,
      total: total,
      healthScore: healthScore,
    );
  }

  factory ComponentHealthInfoModel.fromEntity(ComponentHealthInfo entity) {
    return ComponentHealthInfoModel(
      type: entity.type,
      healthy: entity.healthy,
      total: entity.total,
      healthScore: entity.healthScore,
    );
  }
}

/// Data model for [SystemHealth] with JSON serialization support.
@freezed
class SystemHealthModel with _$SystemHealthModel {
  const factory SystemHealthModel({
    required double overallScore,
    required int healthyComponents,
    required int totalComponents,
    required List<AlertModel> alerts,
    required DateTime timestamp,
    int? unhealthyComponents,
    Map<String, ComponentHealthInfoModel>? componentBreakdown,
  }) = _SystemHealthModel;

  const SystemHealthModel._();

  factory SystemHealthModel.fromJson(Map<String, dynamic> json) =>
      _$SystemHealthModelFromJson(json);

  SystemHealth toEntity() {
    return SystemHealth(
      overallScore: overallScore,
      healthyComponents: healthyComponents,
      totalComponents: totalComponents,
      alerts: alerts.map((model) => model.toEntity()).toList(),
      timestamp: timestamp,
      unhealthyComponents: unhealthyComponents,
      componentBreakdown: componentBreakdown?.map(
        (key, value) => MapEntry(key, value.toEntity()),
      ),
    );
  }

  factory SystemHealthModel.fromEntity(SystemHealth entity) {
    return SystemHealthModel(
      overallScore: entity.overallScore,
      healthyComponents: entity.healthyComponents,
      totalComponents: entity.totalComponents,
      alerts: entity.alerts.map((alert) => AlertModel.fromEntity(alert)).toList(),
      timestamp: entity.timestamp,
      unhealthyComponents: entity.unhealthyComponents,
      componentBreakdown: entity.componentBreakdown?.map(
        (key, value) => MapEntry(key, ComponentHealthInfoModel.fromEntity(value)),
      ),
    );
  }
}
