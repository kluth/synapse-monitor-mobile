import 'package:equatable/equatable.dart';

/// Entity representing Astrocyte (cache) statistics.
///
/// Astrocytes manage state in the Synapse Framework through an LRU cache
/// with TTL and namespace support. They track cache performance, hit rates,
/// and capacity utilization.
class AstrocyteStats extends Equatable {
  const AstrocyteStats({
    required this.cacheSize,
    required this.capacity,
    required this.hitRate,
    required this.missRate,
    required this.averageTTL,
    required this.namespaceDistribution,
    required this.evictionCount,
    this.patternMatchOperations,
    this.timestamp,
  });

  /// Current number of entries in the cache
  final int cacheSize;

  /// Maximum capacity of the cache
  final int capacity;

  /// Cache hit rate as a percentage (0-100)
  final double hitRate;

  /// Cache miss rate as a percentage (0-100)
  final double missRate;

  /// Average time-to-live for cache entries
  final Duration averageTTL;

  /// Distribution of cache entries by namespace
  final Map<String, int> namespaceDistribution;

  /// Total number of evicted cache entries
  final int evictionCount;

  /// Number of pattern matching operations performed (optional)
  final int? patternMatchOperations;

  /// Timestamp when stats were collected (optional)
  final DateTime? timestamp;

  /// Calculate cache utilization percentage (0-100)
  double get utilizationPercentage {
    if (capacity == 0) {
      return 0.0;
    }
    return (cacheSize / capacity) * 100;
  }

  /// Check if cache is nearly full (>80% utilized)
  bool get isNearlyFull => utilizationPercentage > 80.0;

  /// Check if cache is at capacity
  bool get isFull => cacheSize >= capacity;

  /// Check if hit rate is healthy (>70%)
  bool get hasHealthyHitRate => hitRate > 70.0;

  /// Check if hit rate is critical (<30%)
  bool get hasCriticalHitRate => hitRate < 30.0;

  /// Get the most used namespace
  String? get mostUsedNamespace {
    if (namespaceDistribution.isEmpty) {
      return null;
    }

    return namespaceDistribution.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  /// Get total namespace count
  int get namespaceCount => namespaceDistribution.length;

  /// Check if eviction rate is high (cache churning)
  bool get hasHighEvictionRate => evictionCount > capacity;

  @override
  List<Object?> get props => [
        cacheSize,
        capacity,
        hitRate,
        missRate,
        averageTTL,
        namespaceDistribution,
        evictionCount,
        patternMatchOperations,
        timestamp,
      ];

  @override
  String toString() => 'AstrocyteStats(size: $cacheSize/$capacity, '
      'hitRate: ${hitRate.toStringAsFixed(1)}%, evictions: $evictionCount)';
}
