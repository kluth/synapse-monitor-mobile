import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/neural_node.dart';

part 'neural_node_model.freezed.dart';
part 'neural_node_model.g.dart';

/// Data model for [NeuralNode] with JSON serialization support.
@freezed
class NeuralNodeModel with _$NeuralNodeModel {
  const factory NeuralNodeModel({
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
  }) = _NeuralNodeModel;

  const NeuralNodeModel._();

  /// Create model from JSON
  factory NeuralNodeModel.fromJson(Map<String, dynamic> json) =>
      _$NeuralNodeModelFromJson(json);

  /// Convert model to domain entity
  NeuralNode toEntity() {
    return NeuralNode(
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
    );
  }

  /// Create model from domain entity
  factory NeuralNodeModel.fromEntity(NeuralNode entity) {
    return NeuralNodeModel(
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
    );
  }
}
