import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/neural_node.dart';
import '../repositories/neuron_repository.dart';

/// Use case for fetching neurons with warning status.
class GetWarningNeurons implements UseCase<List<NeuralNode>, NoParams> {
  const GetWarningNeurons(this._repository);

  final NeuronRepository _repository;

  @override
  Future<Either<Failure, List<NeuralNode>>> call(NoParams params) async {
    return _repository.getWarningNeurons();
  }
}
