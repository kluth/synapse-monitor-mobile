import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/system_health_repository.dart';

/// Use case for fetching custom metrics.
class GetMetrics implements UseCase<Map<String, double>, NoParams> {
  const GetMetrics(this._repository);

  final SystemHealthRepository _repository;

  @override
  Future<Either<Failure, Map<String, double>>> call(NoParams params) async {
    return _repository.getMetrics();
  }
}
