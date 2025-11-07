import 'package:equatable/equatable.dart';

import 'neural_node.dart';

/// Entity representing a stateful cortical neuron.
///
/// CorticalNeurons maintain accumulated state across processing cycles
/// and are designed for long-running microservices. They track state
/// size, mutations, uptime, and restart count.
class CorticalNeuron extends NeuralNode {
  const CorticalNeuron({
    required super.id,
    required super.name,
    required super.type,
    required super.status,
    required super.activationThreshold,
    required super.processedSignalCount,
    required super.averageProcessingTime,
    required super.lastActiveAt,
    super.description,
    super.metadata,
    required this.stateSize,
    required this.stateChanges,
    required this.uptime,
    required this.restartCount,
    this.currentState,
  });

  /// Size of the accumulated state in bytes
  final int stateSize;

  /// Number of state mutations that have occurred
  final int stateChanges;

  /// Total time the neuron has been running
  final Duration uptime;

  /// Number of times the neuron has been restarted
  final int restartCount;

  /// Current state data (optional, may be large)
  final Map<String, dynamic>? currentState;

  /// Calculate state change rate (changes per hour)
  double get stateChangeRate {
    if (uptime.inHours == 0) {
      return stateChanges.toDouble();
    }
    return stateChanges / uptime.inHours;
  }

  /// Check if neuron is newly started (less than 1 hour uptime)
  bool get isNewlyStarted => uptime.inHours < 1;

  /// Check if neuron has been restarted recently
  bool get hasFrequentRestarts => restartCount > 5;

  @override
  List<Object?> get props => [
        ...super.props,
        stateSize,
        stateChanges,
        uptime,
        restartCount,
        currentState,
      ];

  @override
  String toString() => 'CorticalNeuron(id: $id, name: $name, '
      'uptime: ${uptime.inHours}h, restarts: $restartCount)';
}
