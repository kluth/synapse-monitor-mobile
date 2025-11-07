import 'neural_node.dart';

/// Entity representing a stateless reflex neuron.
///
/// ReflexNeurons are event-driven, stateless operations that activate
/// on-demand and scale to zero when idle. Ideal for serverless functions.
/// They track invocations, cold starts, and scale-to-zero events.
class ReflexNeuron extends NeuralNode {
  const ReflexNeuron({
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
    required this.invocationCount,
    required this.coldStartCount,
    required this.scaleToZeroEvents,
    required this.responseTime,
    required this.lastInvocationAt,
  });

  /// Total number of times the neuron has been invoked
  final int invocationCount;

  /// Number of cold start events (activation from idle state)
  final int coldStartCount;

  /// Number of times the neuron has scaled to zero
  final int scaleToZeroEvents;

  /// Average response time for invocations
  final Duration responseTime;

  /// Timestamp of the last invocation
  final DateTime lastInvocationAt;

  /// Calculate cold start rate as percentage of total invocations
  double get coldStartRate {
    if (invocationCount == 0) {
      return 0.0;
    }
    return (coldStartCount / invocationCount) * 100;
  }

  /// Check if neuron is currently idle (last invocation > 5 minutes ago)
  bool get isIdle {
    final now = DateTime.now();
    final idleThreshold = now.subtract(const Duration(minutes: 5));
    return lastInvocationAt.isBefore(idleThreshold);
  }

  /// Check if neuron has high cold start rate (>20%)
  bool get hasHighColdStartRate => coldStartRate > 20.0;

  /// Check if response time is acceptable (<500ms)
  bool get hasAcceptableResponseTime => responseTime.inMilliseconds < 500;

  @override
  List<Object?> get props => [
        ...super.props,
        invocationCount,
        coldStartCount,
        scaleToZeroEvents,
        responseTime,
        lastInvocationAt,
      ];

  @override
  String toString() => 'ReflexNeuron(id: $id, name: $name, '
      'invocations: $invocationCount, coldStarts: $coldStartCount)';
}
