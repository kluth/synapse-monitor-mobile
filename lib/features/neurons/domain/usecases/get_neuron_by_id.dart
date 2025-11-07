import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/neural_node.dart';
import '../repositories/neuron_repository.dart';

/// Use case for fetching a specific neuron by its ID.
///
/// Returns the neuron with the specified ID, or a [NotFoundFailure]
/// if the neuron doesn't exist.
///
/// Example:
/// ```dart
/// final useCase = GetNeuronById(repository);
/// final result = await useCase(GetNeuronByIdParams(id: 'neuron-123'));
/// result.fold(
///   (failure) => print('Error: $failure'),
///   (neuron) => print('Found neuron: ${neuron.name}'),
/// );
/// ```
class GetNeuronById implements UseCase<NeuralNode, GetNeuronByIdParams> {
  const GetNeuronById(this._repository);

  final NeuronRepository _repository;

  @override
  Future<Either<Failure, NeuralNode>> call(GetNeuronByIdParams params) async {
    return _repository.getNeuronById(params.id);
  }
}

/// Parameters for [GetNeuronById] use case.
class GetNeuronByIdParams extends Equatable {
  const GetNeuronByIdParams({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}
