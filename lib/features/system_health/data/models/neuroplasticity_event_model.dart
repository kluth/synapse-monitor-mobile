import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/neuroplasticity_event.dart';

part 'neuroplasticity_event_model.freezed.dart';
part 'neuroplasticity_event_model.g.dart';

/// Data model for [NeuroplasticityEvent] with JSON serialization support.
@freezed
class NeuroplasticityEventModel with _$NeuroplasticityEventModel {
  const factory NeuroplasticityEventModel({
    required String id,
    required String type,
    required String description,
    required String affectedComponent,
    required DateTime timestamp,
    required String outcome,
    Map<String, dynamic>? beforeState,
    Map<String, dynamic>? afterState,
    int? durationMs,
    Map<String, dynamic>? metadata,
  }) = _NeuroplasticityEventModel;

  const NeuroplasticityEventModel._();

  factory NeuroplasticityEventModel.fromJson(Map<String, dynamic> json) =>
      _$NeuroplasticityEventModelFromJson(json);

  NeuroplasticityEvent toEntity() {
    return NeuroplasticityEvent(
      id: id,
      type: type,
      description: description,
      affectedComponent: affectedComponent,
      timestamp: timestamp,
      outcome: outcome,
      beforeState: beforeState,
      afterState: afterState,
      duration: durationMs != null ? Duration(milliseconds: durationMs!) : null,
      metadata: metadata,
    );
  }

  factory NeuroplasticityEventModel.fromEntity(NeuroplasticityEvent entity) {
    return NeuroplasticityEventModel(
      id: entity.id,
      type: entity.type,
      description: entity.description,
      affectedComponent: entity.affectedComponent,
      timestamp: entity.timestamp,
      outcome: entity.outcome,
      beforeState: entity.beforeState,
      afterState: entity.afterState,
      durationMs: entity.duration?.inMilliseconds,
      metadata: entity.metadata,
    );
  }
}
