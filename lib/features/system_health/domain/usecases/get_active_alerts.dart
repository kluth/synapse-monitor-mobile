import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/alert.dart';
import '../repositories/system_health_repository.dart';

/// Use case for fetching all active alerts.
class GetActiveAlerts implements UseCase<List<Alert>, NoParams> {
  const GetActiveAlerts(this._repository);

  final SystemHealthRepository _repository;

  @override
  Future<Either<Failure, List<Alert>>> call(NoParams params) async {
    return _repository.getActiveAlerts();
  }
}
