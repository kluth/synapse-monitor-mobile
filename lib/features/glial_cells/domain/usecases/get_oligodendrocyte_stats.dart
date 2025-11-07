import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/oligodendrocyte_stats.dart';
import '../repositories/glial_cells_repository.dart';

/// Use case for fetching Oligodendrocyte (performance optimizer) statistics.
class GetOligodendrocyteStats
    implements UseCase<OligodendrocyteStats, NoParams> {
  const GetOligodendrocyteStats(this._repository);

  final GlialCellsRepository _repository;

  @override
  Future<Either<Failure, OligodendrocyteStats>> call(NoParams params) async {
    return _repository.getOligodendrocyteStats();
  }
}
