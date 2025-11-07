import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/neural_node.dart';
import '../repositories/neuron_repository.dart';

/// Use case for filtering neurons by type.
///
/// Returns neurons of a specific type: 'neural_node', 'cortical', or 'reflex'.
class FilterNeuronsByType
    implements UseCase<List<NeuralNode>, FilterNeuronsByTypeParams> {
  const FilterNeuronsByType(this._repository);

  final NeuronRepository _repository;

  @override
  Future<Either<Failure, List<NeuralNode>>> call(
    FilterNeuronsByTypeParams params,
  ) async {
    return _repository.filterNeuronsByType(params.type);
  }
}

/// Parameters for [FilterNeuronsByType] use case.
class FilterNeuronsByTypeParams extends Equatable {
  const FilterNeuronsByTypeParams({required this.type});

  final String type;

  @override
  List<Object?> get props => [type];
}
