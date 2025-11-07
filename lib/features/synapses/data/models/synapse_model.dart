import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/synapse.dart';

part 'synapse_model.freezed.dart';
part 'synapse_model.g.dart';

/// Data model for [Synapse] with JSON serialization support.
@freezed
class SynapseModel with _$SynapseModel {
  const factory SynapseModel({
    required String id,
    required String sourceNeuronId,
    required String targetNeuronId,
    required double weight,
    required String signalType,
    required bool isMyelinated,
    required int usageCount,
    required DateTime lastStrengthenedAt,
    required bool isPruningCandidate,
    DateTime? createdAt,
    int? transmissionSpeedMs,
  }) = _SynapseModel;

  const SynapseModel._();

  /// Create model from JSON
  factory SynapseModel.fromJson(Map<String, dynamic> json) =>
      _$SynapseModelFromJson(json);

  /// Convert model to domain entity
  Synapse toEntity() {
    return Synapse(
      id: id,
      sourceNeuronId: sourceNeuronId,
      targetNeuronId: targetNeuronId,
      weight: weight,
      signalType: signalType,
      isMyelinated: isMyelinated,
      usageCount: usageCount,
      lastStrengthenedAt: lastStrengthenedAt,
      isPruningCandidate: isPruningCandidate,
      createdAt: createdAt,
      transmissionSpeed: transmissionSpeedMs != null
          ? Duration(milliseconds: transmissionSpeedMs!)
          : null,
    );
  }

  /// Create model from domain entity
  factory SynapseModel.fromEntity(Synapse entity) {
    return SynapseModel(
      id: entity.id,
      sourceNeuronId: entity.sourceNeuronId,
      targetNeuronId: entity.targetNeuronId,
      weight: entity.weight,
      signalType: entity.signalType,
      isMyelinated: entity.isMyelinated,
      usageCount: entity.usageCount,
      lastStrengthenedAt: entity.lastStrengthenedAt,
      isPruningCandidate: entity.isPruningCandidate,
      createdAt: entity.createdAt,
      transmissionSpeedMs: entity.transmissionSpeed?.inMilliseconds,
    );
  }
}
