import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/neural_node.dart';
import '../repositories/neuron_repository.dart';

/// Use case for searching neurons by name.
class SearchNeurons implements UseCase<List<NeuralNode>, SearchNeuronsParams> {
  const SearchNeurons(this._repository);

  final NeuronRepository _repository;

  @override
  Future<Either<Failure, List<NeuralNode>>> call(
    SearchNeuronsParams params,
  ) async {
    return _repository.searchNeurons(params.query);
  }
}

/// Parameters for [SearchNeurons] use case.
class SearchNeuronsParams extends Equatable {
  const SearchNeuronsParams({required this.query});

  final String query;

  @override
  List<Object?> get props => [query];
}
