import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/neural_node.dart';
import '../repositories/neuron_repository.dart';

/// Use case for fetching all neurons from the system.
///
/// Returns a list of all neural processing units (neurons) currently
/// active in the Synapse Framework backend.
///
/// Example:
/// ```dart
/// final useCase = GetNeurons(repository);
/// final result = await useCase(NoParams());
/// result.fold(
///   (failure) => print('Error: $failure'),
///   (neurons) => print('Found ${neurons.length} neurons'),
/// );
/// ```
class GetNeurons implements UseCase<List<NeuralNode>, NoParams> {
  const GetNeurons(this._repository);

  final NeuronRepository _repository;

  @override
  Future<Either<Failure, List<NeuralNode>>> call(NoParams params) async {
    return _repository.getNeurons();
  }
}
