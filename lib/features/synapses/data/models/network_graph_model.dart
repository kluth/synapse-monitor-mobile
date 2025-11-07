import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/network_graph.dart';
import 'synapse_model.dart';

part 'network_graph_model.freezed.dart';
part 'network_graph_model.g.dart';

/// Data model for [NetworkGraph] with JSON serialization support.
@freezed
class NetworkGraphModel with _$NetworkGraphModel {
  const factory NetworkGraphModel({
    required List<String> neuronIds,
    required List<SynapseModel> synapses,
    required int depth,
    required double density,
    required int totalNeurons,
    required int totalConnections,
    @Default(false) bool hasCycles,
    DateTime? timestamp,
  }) = _NetworkGraphModel;

  const NetworkGraphModel._();

  /// Create model from JSON
  factory NetworkGraphModel.fromJson(Map<String, dynamic> json) =>
      _$NetworkGraphModelFromJson(json);

  /// Convert model to domain entity
  NetworkGraph toEntity() {
    return NetworkGraph(
      neuronIds: neuronIds,
      synapses: synapses.map((model) => model.toEntity()).toList(),
      depth: depth,
      density: density,
      totalNeurons: totalNeurons,
      totalConnections: totalConnections,
      hasCycles: hasCycles,
      timestamp: timestamp,
    );
  }

  /// Create model from domain entity
  factory NetworkGraphModel.fromEntity(NetworkGraph entity) {
    return NetworkGraphModel(
      neuronIds: entity.neuronIds,
      synapses: entity.synapses
          .map((synapse) => SynapseModel.fromEntity(synapse))
          .toList(),
      depth: entity.depth,
      density: entity.density,
      totalNeurons: entity.totalNeurons,
      totalConnections: entity.totalConnections,
      hasCycles: entity.hasCycles,
      timestamp: entity.timestamp,
    );
  }
}
