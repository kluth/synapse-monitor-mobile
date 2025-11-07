import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/reflex_neuron.dart';

part 'reflex_neuron_model.freezed.dart';
part 'reflex_neuron_model.g.dart';

/// Data model for [ReflexNeuron] with JSON serialization support.
///
/// Extends the base NeuralNode model with stateless reflex neuron properties.
@freezed
class ReflexNeuronModel with _$ReflexNeuronModel {
  const factory ReflexNeuronModel({
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
    // Reflex-specific properties
    required int invocationCount,
    required int coldStartCount,
    required int scaleToZeroEvents,
    required int responseTimeMs,
    required DateTime lastInvocationAt,
  }) = _ReflexNeuronModel;

  const ReflexNeuronModel._();

  /// Create model from JSON
  factory ReflexNeuronModel.fromJson(Map<String, dynamic> json) =>
      _$ReflexNeuronModelFromJson(json);

  /// Convert model to domain entity
  ReflexNeuron toEntity() {
    return ReflexNeuron(
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
      invocationCount: invocationCount,
      coldStartCount: coldStartCount,
      scaleToZeroEvents: scaleToZeroEvents,
      responseTime: Duration(milliseconds: responseTimeMs),
      lastInvocationAt: lastInvocationAt,
    );
  }

  /// Create model from domain entity
  factory ReflexNeuronModel.fromEntity(ReflexNeuron entity) {
    return ReflexNeuronModel(
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
      invocationCount: entity.invocationCount,
      coldStartCount: entity.coldStartCount,
      scaleToZeroEvents: entity.scaleToZeroEvents,
      responseTimeMs: entity.responseTime.inMilliseconds,
      lastInvocationAt: entity.lastInvocationAt,
    );
  }
}
