import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/error_log.dart';
import '../repositories/system_health_repository.dart';

/// Use case for fetching error logs.
class GetErrorLogs implements UseCase<List<ErrorLog>, GetErrorLogsParams> {
  const GetErrorLogs(this._repository);

  final SystemHealthRepository _repository;

  @override
  Future<Either<Failure, List<ErrorLog>>> call(
    GetErrorLogsParams params,
  ) async {
    return _repository.getErrorLogs(
      serviceName: params.serviceName,
      limit: params.limit,
    );
  }
}

/// Parameters for [GetErrorLogs] use case.
class GetErrorLogsParams extends Equatable {
  const GetErrorLogsParams({
    this.serviceName,
    this.limit = 50,
  });

  final String? serviceName;
  final int limit;

  @override
  List<Object?> get props => [serviceName, limit];
}
