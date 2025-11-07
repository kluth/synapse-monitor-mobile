import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/astrocyte_stats.dart';

part 'astrocyte_stats_model.freezed.dart';
part 'astrocyte_stats_model.g.dart';

/// Data model for [AstrocyteStats] with JSON serialization support.
@freezed
class AstrocyteStatsModel with _$AstrocyteStatsModel {
  const factory AstrocyteStatsModel({
    required int cacheSize,
    required int capacity,
    required double hitRate,
    required double missRate,
    required int averageTTLMs,
    required Map<String, int> namespaceDistribution,
    required int evictionCount,
    int? patternMatchOperations,
    DateTime? timestamp,
  }) = _AstrocyteStatsModel;

  const AstrocyteStatsModel._();

  /// Create model from JSON
  factory AstrocyteStatsModel.fromJson(Map<String, dynamic> json) =>
      _$AstrocyteStatsModelFromJson(json);

  /// Convert model to domain entity
  AstrocyteStats toEntity() {
    return AstrocyteStats(
      cacheSize: cacheSize,
      capacity: capacity,
      hitRate: hitRate,
      missRate: missRate,
      averageTTL: Duration(milliseconds: averageTTLMs),
      namespaceDistribution: namespaceDistribution,
      evictionCount: evictionCount,
      patternMatchOperations: patternMatchOperations,
      timestamp: timestamp,
    );
  }

  /// Create model from domain entity
  factory AstrocyteStatsModel.fromEntity(AstrocyteStats entity) {
    return AstrocyteStatsModel(
      cacheSize: entity.cacheSize,
      capacity: entity.capacity,
      hitRate: entity.hitRate,
      missRate: entity.missRate,
      averageTTLMs: entity.averageTTL.inMilliseconds,
      namespaceDistribution: entity.namespaceDistribution,
      evictionCount: entity.evictionCount,
      patternMatchOperations: entity.patternMatchOperations,
      timestamp: entity.timestamp,
    );
  }
}
