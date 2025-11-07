import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/ependymal_stats.dart';
import '../repositories/glial_cells_repository.dart';

/// Use case for fetching Ependymal (API gateway) statistics.
class GetEpendymalStats implements UseCase<EpendymalStats, NoParams> {
  const GetEpendymalStats(this._repository);

  final GlialCellsRepository _repository;

  @override
  Future<Either<Failure, EpendymalStats>> call(NoParams params) async {
    return _repository.getEpendymalStats();
  }
}
