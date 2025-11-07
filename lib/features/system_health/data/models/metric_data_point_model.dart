import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/metric_data_point.dart';

part 'metric_data_point_model.freezed.dart';
part 'metric_data_point_model.g.dart';

/// Data model for [MetricDataPoint] with JSON serialization support.
@freezed
class MetricDataPointModel with _$MetricDataPointModel {
  const factory MetricDataPointModel({
    required DateTime timestamp,
    required double value,
    String? label,
    Map<String, dynamic>? metadata,
  }) = _MetricDataPointModel;

  const MetricDataPointModel._();

  factory MetricDataPointModel.fromJson(Map<String, dynamic> json) =>
      _$MetricDataPointModelFromJson(json);

  MetricDataPoint toEntity() {
    return MetricDataPoint(
      timestamp: timestamp,
      value: value,
      label: label,
      metadata: metadata,
    );
  }

  factory MetricDataPointModel.fromEntity(MetricDataPoint entity) {
    return MetricDataPointModel(
      timestamp: entity.timestamp,
      value: entity.value,
      label: entity.label,
      metadata: entity.metadata,
    );
  }
}
