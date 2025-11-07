import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/cortical_neuron.dart';

part 'cortical_neuron_model.freezed.dart';
part 'cortical_neuron_model.g.dart';

/// Data model for [CorticalNeuron] with JSON serialization support.
///
/// Extends the base NeuralNode model with stateful cortical neuron properties.
@freezed
class CorticalNeuronModel with _$CorticalNeuronModel {
  const factory CorticalNeuronModel({
    required String id,
    required String name,
    required String type,
    required String status,
    required double activationThreshold,
    required int processedSignalCount,
    required int averageProcessingTimeMs,
    required DateTime lastActiveAt,
    String? description,
    Map<String, dynamic>? metadata,
    // Cortical-specific properties
    required int stateSize,
    required int stateChanges,
    required int uptimeMs,
    required int restartCount,
    Map<String, dynamic>? currentState,
  }) = _CorticalNeuronModel;

  const CorticalNeuronModel._();

  /// Create model from JSON
  factory CorticalNeuronModel.fromJson(Map<String, dynamic> json) =>
      _$CorticalNeuronModelFromJson(json);

  /// Convert model to domain entity
  CorticalNeuron toEntity() {
    return CorticalNeuron(
      id: id,
      name: name,
      type: type,
      status: status,
      activationThreshold: activationThreshold,
      processedSignalCount: processedSignalCount,
      averageProcessingTime: Duration(milliseconds: averageProcessingTimeMs),
      lastActiveAt: lastActiveAt,
      description: description,
      metadata: metadata,
      stateSize: stateSize,
      stateChanges: stateChanges,
      uptime: Duration(milliseconds: uptimeMs),
      restartCount: restartCount,
      currentState: currentState,
    );
  }

  /// Create model from domain entity
  factory CorticalNeuronModel.fromEntity(CorticalNeuron entity) {
    return CorticalNeuronModel(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      status: entity.status,
      activationThreshold: entity.activationThreshold,
      processedSignalCount: entity.processedSignalCount,
      averageProcessingTimeMs: entity.averageProcessingTime.inMilliseconds,
      lastActiveAt: entity.lastActiveAt,
      description: entity.description,
      metadata: entity.metadata,
      stateSize: entity.stateSize,
      stateChanges: entity.stateChanges,
      uptimeMs: entity.uptime.inMilliseconds,
      restartCount: entity.restartCount,
      currentState: entity.currentState,
    );
  }
}
