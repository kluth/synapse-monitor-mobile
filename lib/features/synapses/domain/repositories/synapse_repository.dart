import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/network_graph.dart';
import '../entities/synapse.dart';

/// Repository interface for synapse-related operations.
///
/// Defines the contract for accessing and managing synaptic connections
/// between neurons in the Synapse Framework.
abstract class SynapseRepository {
  /// Fetch all synapses from the backend.
  ///
  /// Returns a [Right] with list of [Synapse] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<Synapse>>> getSynapses();

  /// Fetch a specific synapse by its ID.
  ///
  /// Parameters:
  /// - [id]: The unique identifier of the synapse
  ///
  /// Returns a [Right] with [Synapse] on success,
  /// or a [Left] with [Failure] on error (including [NotFoundFailure] if not found).
  Future<Either<Failure, Synapse>> getSynapseById(String id);

  /// Fetch the complete network graph topology.
  ///
  /// Returns a [Right] with [NetworkGraph] containing all neurons and connections,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, NetworkGraph>> getNetworkGraph();

  /// Get synapses that are candidates for pruning (removal).
  ///
  /// Returns a [Right] with list of synapses at risk of being pruned,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<Synapse>>> getPruningCandidates();

  /// Get synapses by source neuron ID.
  ///
  /// Parameters:
  /// - [neuronId]: ID of the source (pre-synaptic) neuron
  ///
  /// Returns a [Right] with list of outgoing synapses,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<Synapse>>> getSynapsesBySourceNeuron(
    String neuronId,
  );

  /// Get synapses by target neuron ID.
  ///
  /// Parameters:
  /// - [neuronId]: ID of the target (post-synaptic) neuron
  ///
  /// Returns a [Right] with list of incoming synapses,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<Synapse>>> getSynapsesByTargetNeuron(
    String neuronId,
  );

  /// Get myelinated synapses (optimized for fast transmission).
  ///
  /// Returns a [Right] with list of myelinated synapses,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<Synapse>>> getMyelinatedSynapses();

  /// Get synapses by signal type.
  ///
  /// Parameters:
  /// - [signalType]: Type of signal ('excitatory' or 'inhibitory')
  ///
  /// Returns a [Right] with filtered list of synapses,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<Synapse>>> getSynapsesBySignalType(
    String signalType,
  );

  /// Stream real-time synapse updates via WebSocket.
  ///
  /// Returns a stream of [Synapse] updates.
  /// Stream emits when synapses are created, modified, or deleted.
  Stream<Synapse> watchSynapseUpdates();

  /// Stream network topology changes.
  ///
  /// Returns a stream of [NetworkGraph] updates.
  /// Stream emits when the network structure changes.
  Stream<NetworkGraph> watchNetworkTopology();
}
