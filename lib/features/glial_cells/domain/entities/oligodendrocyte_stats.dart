import 'package:equatable/equatable.dart';

/// Entity representing Oligodendrocyte (performance optimizer) statistics.
///
/// Oligodendrocytes optimize performance through connection pooling,
/// resource caching with memoization, and myelination tracking
/// for optimized communication paths.
class OligodendrocyteStats extends Equatable {
  const OligodendrocyteStats({
    required this.connectionPoolSize,
    required this.maxConnectionPoolSize,
    required this.resourceCacheHits,
    required this.resourceCacheMisses,
    required this.memoizationHits,
    required this.myelinatedPathsCount,
    required this.poolExhaustionEvents,
    this.averageConnectionAcquisitionTime,
    this.timestamp,
  });

  /// Current number of active connections in the pool
  final int connectionPoolSize;

  /// Maximum allowed connections in the pool
  final int maxConnectionPoolSize;

  /// Number of successful resource cache hits
  final int resourceCacheHits;

  /// Number of resource cache misses
  final int resourceCacheMisses;

  /// Number of successful memoization hits
  final int memoizationHits;

  /// Number of myelinated (optimized) communication paths
  final int myelinatedPathsCount;

  /// Number of times the connection pool was exhausted
  final int poolExhaustionEvents;

  /// Average time to acquire a connection from the pool (optional)
  final Duration? averageConnectionAcquisitionTime;

  /// Timestamp when stats were collected (optional)
  final DateTime? timestamp;

  /// Calculate connection pool utilization percentage (0-100)
  double get poolUtilizationPercentage {
    if (maxConnectionPoolSize == 0) {
      return 0.0;
    }
    return (connectionPoolSize / maxConnectionPoolSize) * 100;
  }

  /// Check if pool is nearly exhausted (>80% utilized)
  bool get isPoolNearlyExhausted => poolUtilizationPercentage > 80.0;

  /// Check if pool is at capacity
  bool get isPoolExhausted => connectionPoolSize >= maxConnectionPoolSize;

  /// Calculate resource cache hit rate percentage
  double get resourceCacheHitRate {
    final totalRequests = resourceCacheHits + resourceCacheMisses;
    if (totalRequests == 0) {
      return 0.0;
    }
    return (resourceCacheHits / totalRequests) * 100;
  }

  /// Check if resource cache performance is healthy (>70% hit rate)
  bool get hasHealthyCachePerformance => resourceCacheHitRate > 70.0;

  /// Check if there have been frequent pool exhaustion events
  bool get hasFrequentExhaustion => poolExhaustionEvents > 10;

  /// Check if memoization is effective (many hits)
  bool get hasEffectiveMemoization => memoizationHits > 100;

  /// Get total cache operations
  int get totalCacheOperations => resourceCacheHits + resourceCacheMisses;

  @override
  List<Object?> get props => [
        connectionPoolSize,
        maxConnectionPoolSize,
        resourceCacheHits,
        resourceCacheMisses,
        memoizationHits,
        myelinatedPathsCount,
        poolExhaustionEvents,
        averageConnectionAcquisitionTime,
        timestamp,
      ];

  @override
  String toString() => 'OligodendrocyteStats(pool: $connectionPoolSize/$maxConnectionPoolSize, '
      'cacheHitRate: ${resourceCacheHitRate.toStringAsFixed(1)}%, myelinated: $myelinatedPathsCount)';
}
