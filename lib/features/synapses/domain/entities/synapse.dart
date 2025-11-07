import 'package:equatable/equatable.dart';

/// Entity representing a synaptic connection between neurons.
///
/// Synapses are type-safe communication channels that connect neurons
/// in the Synapse Framework. They feature configurable signal strength,
/// excitatory/inhibitory types, myelination for fast transmission,
/// and Hebbian learning through strengthening/weakening.
class Synapse extends Equatable {
  const Synapse({
    required this.id,
    required this.sourceNeuronId,
    required this.targetNeuronId,
    required this.weight,
    required this.signalType,
    required this.isMyelinated,
    required this.usageCount,
    required this.lastStrengthenedAt,
    required this.isPruningCandidate,
    this.createdAt,
    this.transmissionSpeed,
  });

  /// Unique identifier for the synapse
  final String id;

  /// ID of the source (pre-synaptic) neuron
  final String sourceNeuronId;

  /// ID of the target (post-synaptic) neuron
  final String targetNeuronId;

  /// Signal strength (weight) between 0.0 and 1.0
  final double weight;

  /// Type of signal: 'excitatory' or 'inhibitory'
  final String signalType;

  /// Whether the connection is myelinated (optimized for fast transmission)
  final bool isMyelinated;

  /// Number of signals transmitted through this synapse
  final int usageCount;

  /// Timestamp of last Hebbian learning strengthening event
  final DateTime lastStrengthenedAt;

  /// Whether this synapse is at risk of being pruned (removed)
  final bool isPruningCandidate;

  /// When the synapse was created (optional)
  final DateTime? createdAt;

  /// Transmission speed in milliseconds (optional)
  final Duration? transmissionSpeed;

  /// Check if synapse is excitatory
  bool get isExcitatory => signalType == 'excitatory';

  /// Check if synapse is inhibitory
  bool get isInhibitory => signalType == 'inhibitory';

  /// Check if synapse is strong (weight > 0.7)
  bool get isStrong => weight > 0.7;

  /// Check if synapse is weak (weight < 0.3)
  bool get isWeak => weight < 0.3;

  /// Check if synapse is frequently used
  bool get isFrequentlyUsed => usageCount > 1000;

  /// Check if synapse was recently strengthened (within 24 hours)
  bool get wasRecentlyStrengthened {
    final now = DateTime.now();
    final threshold = now.subtract(const Duration(hours: 24));
    return lastStrengthenedAt.isAfter(threshold);
  }

  /// Get connection strength category
  String get strengthCategory {
    if (weight >= 0.8) {
      return 'Very Strong';
    } else if (weight >= 0.6) {
      return 'Strong';
    } else if (weight >= 0.4) {
      return 'Moderate';
    } else if (weight >= 0.2) {
      return 'Weak';
    } else {
      return 'Very Weak';
    }
  }

  @override
  List<Object?> get props => [
        id,
        sourceNeuronId,
        targetNeuronId,
        weight,
        signalType,
        isMyelinated,
        usageCount,
        lastStrengthenedAt,
        isPruningCandidate,
        createdAt,
        transmissionSpeed,
      ];

  @override
  String toString() => 'Synapse(id: $id, $sourceNeuronId -> $targetNeuronId, '
      'weight: ${weight.toStringAsFixed(2)}, type: $signalType)';
}
