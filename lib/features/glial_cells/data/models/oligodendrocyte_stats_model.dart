import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/oligodendrocyte_stats.dart';

part 'oligodendrocyte_stats_model.freezed.dart';
part 'oligodendrocyte_stats_model.g.dart';

/// Data model for [OligodendrocyteStats] with JSON serialization support.
@freezed
class OligodendrocyteStatsModel with _$OligodendrocyteStatsModel {
  const factory OligodendrocyteStatsModel({
    required int connectionPoolSize,
    required int maxConnectionPoolSize,
    required int resourceCacheHits,
    required int resourceCacheMisses,
    required int memoizationHits,
    required int myelinatedPathsCount,
    required int poolExhaustionEvents,
    int? averageConnectionAcquisitionTimeMs,
    DateTime? timestamp,
  }) = _OligodendrocyteStatsModel;

  const OligodendrocyteStatsModel._();

  /// Create model from JSON
  factory OligodendrocyteStatsModel.fromJson(Map<String, dynamic> json) =>
      _$OligodendrocyteStatsModelFromJson(json);

  /// Convert model to domain entity
  OligodendrocyteStats toEntity() {
    return OligodendrocyteStats(
      connectionPoolSize: connectionPoolSize,
      maxConnectionPoolSize: maxConnectionPoolSize,
      resourceCacheHits: resourceCacheHits,
      resourceCacheMisses: resourceCacheMisses,
      memoizationHits: memoizationHits,
      myelinatedPathsCount: myelinatedPathsCount,
      poolExhaustionEvents: poolExhaustionEvents,
      averageConnectionAcquisitionTime: averageConnectionAcquisitionTimeMs != null
          ? Duration(milliseconds: averageConnectionAcquisitionTimeMs!)
          : null,
      timestamp: timestamp,
    );
  }

  /// Create model from domain entity
  factory OligodendrocyteStatsModel.fromEntity(OligodendrocyteStats entity) {
    return OligodendrocyteStatsModel(
      connectionPoolSize: entity.connectionPoolSize,
      maxConnectionPoolSize: entity.maxConnectionPoolSize,
      resourceCacheHits: entity.resourceCacheHits,
      resourceCacheMisses: entity.resourceCacheMisses,
      memoizationHits: entity.memoizationHits,
      myelinatedPathsCount: entity.myelinatedPathsCount,
      poolExhaustionEvents: entity.poolExhaustionEvents,
      averageConnectionAcquisitionTimeMs:
          entity.averageConnectionAcquisitionTime?.inMilliseconds,
      timestamp: entity.timestamp,
    );
  }
}
