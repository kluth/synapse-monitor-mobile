import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/astrocyte_stats.dart';
import '../repositories/glial_cells_repository.dart';

/// Use case for fetching Astrocyte (cache) statistics.
class GetAstrocyteStats implements UseCase<AstrocyteStats, NoParams> {
  const GetAstrocyteStats(this._repository);

  final GlialCellsRepository _repository;

  @override
  Future<Either<Failure, AstrocyteStats>> call(NoParams params) async {
    return _repository.getAstrocyteStats();
  }
}
