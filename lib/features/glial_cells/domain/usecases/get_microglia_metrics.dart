import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/microglia_metrics.dart';
import '../repositories/glial_cells_repository.dart';

/// Use case for fetching Microglia (health monitoring) metrics.
class GetMicrogliaMetrics implements UseCase<MicrogliaMetrics, NoParams> {
  const GetMicrogliaMetrics(this._repository);

  final GlialCellsRepository _repository;

  @override
  Future<Either<Failure, MicrogliaMetrics>> call(NoParams params) async {
    return _repository.getMicrogliaMetrics();
  }
}
