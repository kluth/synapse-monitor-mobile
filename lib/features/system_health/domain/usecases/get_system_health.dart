import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/system_health.dart';
import '../repositories/system_health_repository.dart';

/// Use case for fetching current system health status.
class GetSystemHealth implements UseCase<SystemHealth, NoParams> {
  const GetSystemHealth(this._repository);

  final SystemHealthRepository _repository;

  @override
  Future<Either<Failure, SystemHealth>> call(NoParams params) async {
    return _repository.getSystemHealth();
  }
}
