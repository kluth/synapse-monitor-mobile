import 'package:equatable/equatable.dart';

import 'synapse.dart';

/// Entity representing the complete neural network topology.
///
/// Provides a view of all neurons and their synaptic connections,
/// including network metrics like depth, density, and connectivity.
class NetworkGraph extends Equatable {
  const NetworkGraph({
    required this.neuronIds,
    required this.synapses,
    required this.depth,
    required this.density,
    required this.totalNeurons,
    required this.totalConnections,
    this.hasCycles = false,
    this.timestamp,
  });

  /// List of all neuron IDs in the network
  final List<String> neuronIds;

  /// List of all synaptic connections
  final List<Synapse> synapses;

  /// Depth of the feed-forward network (number of layers)
  final int depth;

  /// Network density (average connections per neuron)
  final double density;

  /// Total number of neurons in the network
  final int totalNeurons;

  /// Total number of connections in the network
  final int totalConnections;

  /// Whether the network contains feedback loops (cycles)
  final bool hasCycles;

  /// Timestamp when the graph was generated (optional)
  final DateTime? timestamp;

  /// Check if network is sparsely connected (density < 2.0)
  bool get isSparse => density < 2.0;

  /// Check if network is densely connected (density > 5.0)
  bool get isDense => density > 5.0;

  /// Check if network is large (more than 100 neurons)
  bool get isLarge => totalNeurons > 100;

  /// Check if network is complex (depth > 5)
  bool get isComplex => depth > 5;

  /// Get connectivity percentage (0-100)
  double get connectivityPercentage {
    final maxConnections = totalNeurons * (totalNeurons - 1);
    if (maxConnections == 0) {
      return 0.0;
    }
    return (totalConnections / maxConnections) * 100;
  }

  /// Get count of myelinated connections
  int get myelinatedCount {
    return synapses.where((s) => s.isMyelinated).length;
  }

  /// Get count of excitatory connections
  int get excitatoryCount {
    return synapses.where((s) => s.isExcitatory).length;
  }

  /// Get count of inhibitory connections
  int get inhibitoryCount {
    return synapses.where((s) => s.isInhibitory).length;
  }

  /// Get count of pruning candidates
  int get pruningCandidatesCount {
    return synapses.where((s) => s.isPruningCandidate).length;
  }

  /// Get average connection weight
  double get averageWeight {
    if (synapses.isEmpty) {
      return 0.0;
    }
    final totalWeight = synapses.fold<double>(
      0.0,
      (sum, synapse) => sum + synapse.weight,
    );
    return totalWeight / synapses.length;
  }

  @override
  List<Object?> get props => [
        neuronIds,
        synapses,
        depth,
        density,
        totalNeurons,
        totalConnections,
        hasCycles,
        timestamp,
      ];

  @override
  String toString() => 'NetworkGraph(neurons: $totalNeurons, '
      'connections: $totalConnections, depth: $depth, density: ${density.toStringAsFixed(2)})';
}
