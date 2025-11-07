import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/alert.dart';

part 'alert_model.freezed.dart';
part 'alert_model.g.dart';

/// Data model for [Alert] with JSON serialization support.
@freezed
class AlertModel with _$AlertModel {
  const factory AlertModel({
    required String id,
    required String severity,
    required String message,
    required String source,
    required DateTime timestamp,
    required bool isActive,
    DateTime? acknowledgedAt,
    String? acknowledgedBy,
    Map<String, dynamic>? metadata,
  }) = _AlertModel;

  const AlertModel._();

  /// Create model from JSON
  factory AlertModel.fromJson(Map<String, dynamic> json) =>
      _$AlertModelFromJson(json);

  /// Convert model to domain entity
  Alert toEntity() {
    return Alert(
      id: id,
      severity: severity,
      message: message,
      source: source,
      timestamp: timestamp,
      isActive: isActive,
      acknowledgedAt: acknowledgedAt,
      acknowledgedBy: acknowledgedBy,
      metadata: metadata,
    );
  }

  /// Create model from domain entity
  factory AlertModel.fromEntity(Alert entity) {
    return AlertModel(
      id: entity.id,
      severity: entity.severity,
      message: entity.message,
      source: entity.source,
      timestamp: entity.timestamp,
      isActive: entity.isActive,
      acknowledgedAt: entity.acknowledgedAt,
      acknowledgedBy: entity.acknowledgedBy,
      metadata: entity.metadata,
    );
  }
}
