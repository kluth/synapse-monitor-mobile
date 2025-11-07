import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/ependymal_stats.dart';

part 'ependymal_stats_model.freezed.dart';
part 'ependymal_stats_model.g.dart';

/// Data model for [RateLimitingStats] with JSON serialization support.
@freezed
class RateLimitingStatsModel with _$RateLimitingStatsModel {
  const factory RateLimitingStatsModel({
    required int activeRateLimits,
    required int rateLimitViolations,
    required int windowSizeMs,
    int? maxRequestsPerWindow,
  }) = _RateLimitingStatsModel;

  const RateLimitingStatsModel._();

  /// Create model from JSON
  factory RateLimitingStatsModel.fromJson(Map<String, dynamic> json) =>
      _$RateLimitingStatsModelFromJson(json);

  /// Convert model to domain entity
  RateLimitingStats toEntity() {
    return RateLimitingStats(
      activeRateLimits: activeRateLimits,
      rateLimitViolations: rateLimitViolations,
      windowSize: Duration(milliseconds: windowSizeMs),
      maxRequestsPerWindow: maxRequestsPerWindow,
    );
  }

  /// Create model from domain entity
  factory RateLimitingStatsModel.fromEntity(RateLimitingStats entity) {
    return RateLimitingStatsModel(
      activeRateLimits: entity.activeRateLimits,
      rateLimitViolations: entity.rateLimitViolations,
      windowSizeMs: entity.windowSize.inMilliseconds,
      maxRequestsPerWindow: entity.maxRequestsPerWindow,
    );
  }
}

/// Data model for [EpendymalStats] with JSON serialization support.
@freezed
class EpendymalStatsModel with _$EpendymalStatsModel {
  const factory EpendymalStatsModel({
    required int totalRequests,
    required double requestRate,
    required RateLimitingStatsModel rateLimiting,
    required Map<String, int> routeDistribution,
    required int middlewareLatencyMs,
    required Map<String, int> errorResponses,
    double? successRate,
    int? averageResponseTimeMs,
    DateTime? timestamp,
  }) = _EpendymalStatsModel;

  const EpendymalStatsModel._();

  /// Create model from JSON
  factory EpendymalStatsModel.fromJson(Map<String, dynamic> json) =>
      _$EpendymalStatsModelFromJson(json);

  /// Convert model to domain entity
  EpendymalStats toEntity() {
    return EpendymalStats(
      totalRequests: totalRequests,
      requestRate: requestRate,
      rateLimiting: rateLimiting.toEntity(),
      routeDistribution: routeDistribution,
      middlewareLatency: Duration(milliseconds: middlewareLatencyMs),
      errorResponses: errorResponses,
      successRate: successRate,
      averageResponseTime: averageResponseTimeMs != null
          ? Duration(milliseconds: averageResponseTimeMs!)
          : null,
      timestamp: timestamp,
    );
  }

  /// Create model from domain entity
  factory EpendymalStatsModel.fromEntity(EpendymalStats entity) {
    return EpendymalStatsModel(
      totalRequests: entity.totalRequests,
      requestRate: entity.requestRate,
      rateLimiting: RateLimitingStatsModel.fromEntity(entity.rateLimiting),
      routeDistribution: entity.routeDistribution,
      middlewareLatencyMs: entity.middlewareLatency.inMilliseconds,
      errorResponses: entity.errorResponses,
      successRate: entity.successRate,
      averageResponseTimeMs: entity.averageResponseTime?.inMilliseconds,
      timestamp: entity.timestamp,
    );
  }
}
