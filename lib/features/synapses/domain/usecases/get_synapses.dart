import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/synapse.dart';
import '../repositories/synapse_repository.dart';

/// Use case for fetching all synaptic connections from the system.
class GetSynapses implements UseCase<List<Synapse>, NoParams> {
  const GetSynapses(this._repository);

  final SynapseRepository _repository;

  @override
  Future<Either<Failure, List<Synapse>>> call(NoParams params) async {
    return _repository.getSynapses();
  }
}
