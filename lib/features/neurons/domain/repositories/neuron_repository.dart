import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../system_health/domain/entities/metric_data_point.dart';
import '../entities/neural_node.dart';

/// Repository interface for neuron-related operations.
///
/// Defines the contract for accessing and managing neural processing units
/// (neurons) from the Synapse Framework backend.
abstract class NeuronRepository {
  /// Fetch all neurons from the backend.
  ///
  /// Returns a [Right] with list of [NeuralNode] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<NeuralNode>>> getNeurons();

  /// Fetch a specific neuron by its ID.
  ///
  /// Parameters:
  /// - [id]: The unique identifier of the neuron
  ///
  /// Returns a [Right] with [NeuralNode] on success,
  /// or a [Left] with [Failure] on error (including [NotFoundFailure] if not found).
  Future<Either<Failure, NeuralNode>> getNeuronById(String id);

  /// Fetch time-series metrics for a specific neuron.
  ///
  /// Parameters:
  /// - [id]: The unique identifier of the neuron
  /// - [start]: Start of the time range
  /// - [end]: End of the time range
  ///
  /// Returns a [Right] with list of [MetricDataPoint] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<MetricDataPoint>>> getNeuronMetrics(
    String id,
    DateTime start,
    DateTime end,
  );

  /// Filter neurons by type.
  ///
  /// Parameters:
  /// - [type]: Type of neuron ('neural_node', 'cortical', 'reflex')
  ///
  /// Returns a [Right] with filtered list of [NeuralNode] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<NeuralNode>>> filterNeuronsByType(String type);

  /// Search neurons by name.
  ///
  /// Parameters:
  /// - [query]: Search query string
  ///
  /// Returns a [Right] with matching list of [NeuralNode] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<NeuralNode>>> searchNeurons(String query);

  /// Get neurons with error status.
  ///
  /// Returns a [Right] with list of neurons having errors,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<NeuralNode>>> getErrorNeurons();

  /// Get neurons with warning status.
  ///
  /// Returns a [Right] with list of neurons with warnings,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<NeuralNode>>> getWarningNeurons();

  /// Stream real-time neuron updates via WebSocket.
  ///
  /// Returns a stream of [NeuralNode] updates.
  /// Stream emits when neurons change state.
  Stream<NeuralNode> watchNeuronUpdates();

  /// Stream updates for a specific neuron.
  ///
  /// Parameters:
  /// - [id]: The unique identifier of the neuron to watch
  ///
  /// Returns a stream of [NeuralNode] updates for the specified neuron.
  Stream<NeuralNode> watchNeuronById(String id);
}
