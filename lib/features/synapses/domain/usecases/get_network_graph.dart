import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/network_graph.dart';
import '../repositories/synapse_repository.dart';

/// Use case for fetching the complete network topology.
class GetNetworkGraph implements UseCase<NetworkGraph, NoParams> {
  const GetNetworkGraph(this._repository);

  final SynapseRepository _repository;

  @override
  Future<Either<Failure, NetworkGraph>> call(NoParams params) async {
    return _repository.getNetworkGraph();
  }
}
