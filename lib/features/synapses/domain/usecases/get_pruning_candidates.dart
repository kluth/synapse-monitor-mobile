import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/synapse.dart';
import '../repositories/synapse_repository.dart';

/// Use case for fetching synapses that are candidates for pruning.
class GetPruningCandidates implements UseCase<List<Synapse>, NoParams> {
  const GetPruningCandidates(this._repository);

  final SynapseRepository _repository;

  @override
  Future<Either<Failure, List<Synapse>>> call(NoParams params) async {
    return _repository.getPruningCandidates();
  }
}
