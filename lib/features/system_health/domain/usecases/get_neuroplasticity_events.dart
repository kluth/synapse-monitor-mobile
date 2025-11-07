import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/neuroplasticity_event.dart';
import '../repositories/system_health_repository.dart';

/// Use case for fetching neuroplasticity events.
class GetNeuroplasticityEvents
    implements
        UseCase<List<NeuroplasticityEvent>, GetNeuroplasticityEventsParams> {
  const GetNeuroplasticityEvents(this._repository);

  final SystemHealthRepository _repository;

  @override
  Future<Either<Failure, List<NeuroplasticityEvent>>> call(
    GetNeuroplasticityEventsParams params,
  ) async {
    return _repository.getNeuroplasticityEvents(limit: params.limit);
  }
}

/// Parameters for [GetNeuroplasticityEvents] use case.
class GetNeuroplasticityEventsParams extends Equatable {
  const GetNeuroplasticityEventsParams({this.limit = 50});

  final int limit;

  @override
  List<Object?> get props => [limit];
}
