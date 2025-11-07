import 'package:equatable/equatable.dart';

/// Entity representing a neuroplasticity event (self-healing, adaptation).
///
/// Neuroplasticity events track the system's ability to adapt, self-heal,
/// and recover from issues automatically.
class NeuroplasticityEvent extends Equatable {
  const NeuroplasticityEvent({
    required this.id,
    required this.type,
    required this.description,
    required this.affectedComponent,
    required this.timestamp,
    required this.outcome,
    this.beforeState,
    this.afterState,
    this.duration,
    this.metadata,
  });

  /// Unique identifier for the event
  final String id;

  /// Type of neuroplasticity: 'self_healing', 'adaptation', 'recovery', 'optimization'
  final String type;

  /// Human-readable description of what happened
  final String description;

  /// Component that was affected (neuron ID, synapse ID, etc.)
  final String affectedComponent;

  /// When the event occurred
  final DateTime timestamp;

  /// Outcome: 'success', 'failed', 'partial'
  final String outcome;

  /// State before the neuroplasticity event (optional)
  final Map<String, dynamic>? beforeState;

  /// State after the neuroplasticity event (optional)
  final Map<String, dynamic>? afterState;

  /// How long the adaptation took (optional)
  final Duration? duration;

  /// Additional metadata about the event (optional)
  final Map<String, dynamic>? metadata;

  /// Check if event is a self-healing event
  bool get isSelfHealing => type == 'self_healing';

  /// Check if event is an adaptation event
  bool get isAdaptation => type == 'adaptation';

  /// Check if event is a recovery event
  bool get isRecovery => type == 'recovery';

  /// Check if event is an optimization event
  bool get isOptimization => type == 'optimization';

  /// Check if event was successful
  bool get wasSuccessful => outcome == 'success';

  /// Check if event failed
  bool get failed => outcome == 'failed';

  /// Check if event was partially successful
  bool get wasPartial => outcome == 'partial';

  /// Check if event is recent (within last 24 hours)
  bool get isRecent {
    final now = DateTime.now();
    final oneDayAgo = now.subtract(const Duration(hours: 24));
    return timestamp.isAfter(oneDayAgo);
  }

  /// Check if event has state changes recorded
  bool get hasStateChanges => beforeState != null && afterState != null;

  /// Get event age
  Duration get age {
    return DateTime.now().difference(timestamp);
  }

  @override
  List<Object?> get props => [
        id,
        type,
        description,
        affectedComponent,
        timestamp,
        outcome,
        beforeState,
        afterState,
        duration,
        metadata,
      ];

  @override
  String toString() => 'NeuroplasticityEvent(id: $id, type: $type, '
      'component: $affectedComponent, outcome: $outcome)';
}
