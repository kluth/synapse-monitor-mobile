import 'package:equatable/equatable.dart';

/// Base entity for all neural processing units in the Synapse Framework.
///
/// Represents the core properties and behavior of a neuron, including
/// activation thresholds, signal processing metrics, and status.
class NeuralNode extends Equatable {
  const NeuralNode({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.activationThreshold,
    required this.processedSignalCount,
    required this.averageProcessingTime,
    required this.lastActiveAt,
    this.description,
    this.metadata,
  });

  /// Unique identifier for the neuron
  final String id;

  /// Human-readable name of the neuron
  final String name;

  /// Type of neuron: 'neural_node', 'cortical', or 'reflex'
  final String type;

  /// Current status: 'active', 'inactive', 'error', or 'warning'
  final String status;

  /// Threshold value that must be exceeded for activation
  final double activationThreshold;

  /// Total number of signals processed by this neuron
  final int processedSignalCount;

  /// Average time taken to process a signal
  final Duration averageProcessingTime;

  /// Timestamp of the last activation
  final DateTime lastActiveAt;

  /// Optional description of the neuron's purpose
  final String? description;

  /// Optional metadata for custom properties
  final Map<String, dynamic>? metadata;

  /// Check if neuron is currently active
  bool get isActive => status == 'active';

  /// Check if neuron has an error status
  bool get hasError => status == 'error';

  /// Check if neuron has a warning status
  bool get hasWarning => status == 'warning';

  /// Check if neuron is inactive
  bool get isInactive => status == 'inactive';

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        status,
        activationThreshold,
        processedSignalCount,
        averageProcessingTime,
        lastActiveAt,
        description,
        metadata,
      ];

  @override
  String toString() => 'NeuralNode(id: $id, name: $name, type: $type, '
      'status: $status, signals: $processedSignalCount)';
}
