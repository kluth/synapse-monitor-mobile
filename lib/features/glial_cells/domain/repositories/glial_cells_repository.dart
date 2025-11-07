import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/astrocyte_stats.dart';
import '../entities/ependymal_stats.dart';
import '../entities/microglia_metrics.dart';
import '../entities/oligodendrocyte_stats.dart';

/// Repository interface for glial cell operations.
///
/// Defines the contract for accessing statistics and metrics from
/// all glial support systems in the Synapse Framework.
abstract class GlialCellsRepository {
  /// Fetch Astrocyte (cache) statistics.
  ///
  /// Returns a [Right] with [AstrocyteStats] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, AstrocyteStats>> getAstrocyteStats();

  /// Fetch Oligodendrocyte (performance optimizer) statistics.
  ///
  /// Returns a [Right] with [OligodendrocyteStats] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, OligodendrocyteStats>> getOligodendrocyteStats();

  /// Fetch Microglia (health monitoring) metrics.
  ///
  /// Returns a [Right] with [MicrogliaMetrics] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, MicrogliaMetrics>> getMicrogliaMetrics();

  /// Fetch Ependymal (API gateway) statistics.
  ///
  /// Returns a [Right] with [EpendymalStats] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, EpendymalStats>> getEpendymalStats();

  /// Fetch cache statistics by namespace.
  ///
  /// Parameters:
  /// - [namespace]: The namespace to query
  ///
  /// Returns cache statistics for a specific namespace.
  Future<Either<Failure, Map<String, int>>> getAstrocyteNamespaceStats(
    String namespace,
  );

  /// Stream real-time Astrocyte statistics updates.
  ///
  /// Returns a stream of [AstrocyteStats] updates.
  Stream<AstrocyteStats> watchAstrocyteStats();

  /// Stream real-time Oligodendrocyte statistics updates.
  ///
  /// Returns a stream of [OligodendrocyteStats] updates.
  Stream<OligodendrocyteStats> watchOligodendrocyteStats();

  /// Stream real-time Microglia metrics updates.
  ///
  /// Returns a stream of [MicrogliaMetrics] updates.
  Stream<MicrogliaMetrics> watchMicrogliaMetrics();

  /// Stream real-time Ependymal statistics updates.
  ///
  /// Returns a stream of [EpendymalStats] updates.
  Stream<EpendymalStats> watchEpendymalStats();
}
