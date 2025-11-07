import 'package:equatable/equatable.dart';

/// Entity representing Ependymal (API gateway) statistics.
///
/// Ependymal cells manage API gateway functionality with request routing,
/// rate limiting, middleware pipelines, and request statistics.
class EpendymalStats extends Equatable {
  const EpendymalStats({
    required this.totalRequests,
    required this.requestRate,
    required this.rateLimiting,
    required this.routeDistribution,
    required this.middlewareLatency,
    required this.errorResponses,
    this.successRate,
    this.averageResponseTime,
    this.timestamp,
  });

  /// Total number of requests processed
  final int totalRequests;

  /// Current request rate (requests per second)
  final double requestRate;

  /// Rate limiting statistics
  final RateLimitingStats rateLimiting;

  /// Distribution of requests by route/endpoint
  final Map<String, int> routeDistribution;

  /// Average latency added by middleware pipeline
  final Duration middlewareLatency;

  /// HTTP error responses by status code
  final Map<String, int> errorResponses;

  /// Success rate percentage (optional, can be calculated)
  final double? successRate;

  /// Average response time (optional)
  final Duration? averageResponseTime;

  /// Timestamp when stats were collected (optional)
  final DateTime? timestamp;

  /// Get total error count
  int get totalErrors {
    return errorResponses.values.fold<int>(0, (sum, count) => sum + count);
  }

  /// Calculate error rate percentage
  double get errorRatePercentage {
    if (totalRequests == 0) {
      return 0.0;
    }
    return (totalErrors / totalRequests) * 100;
  }

  /// Calculate actual success rate if not provided
  double get calculatedSuccessRate {
    if (successRate != null) {
      return successRate!;
    }

    if (totalRequests == 0) {
      return 100.0;
    }

    final successfulRequests = totalRequests - totalErrors;
    return (successfulRequests / totalRequests) * 100;
  }

  /// Check if success rate is healthy (>95%)
  bool get hasHealthySuccessRate => calculatedSuccessRate > 95.0;

  /// Check if error rate is high (>5%)
  bool get hasHighErrorRate => errorRatePercentage > 5.0;

  /// Check if request rate is very high (>1000 req/s)
  bool get hasHighRequestRate => requestRate > 1000.0;

  /// Check if middleware latency is acceptable (<50ms)
  bool get hasAcceptableMiddlewareLatency => middlewareLatency.inMilliseconds < 50;

  /// Get most accessed route
  String? get mostAccessedRoute {
    if (routeDistribution.isEmpty) {
      return null;
    }

    return routeDistribution.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  /// Get 4xx error count (client errors)
  int get clientErrorCount {
    return errorResponses.entries
        .where((entry) => entry.key.startsWith('4'))
        .fold<int>(0, (sum, entry) => sum + entry.value);
  }

  /// Get 5xx error count (server errors)
  int get serverErrorCount {
    return errorResponses.entries
        .where((entry) => entry.key.startsWith('5'))
        .fold<int>(0, (sum, entry) => sum + entry.value);
  }

  @override
  List<Object?> get props => [
        totalRequests,
        requestRate,
        rateLimiting,
        routeDistribution,
        middlewareLatency,
        errorResponses,
        successRate,
        averageResponseTime,
        timestamp,
      ];

  @override
  String toString() => 'EpendymalStats(requests: $totalRequests, '
      'rate: ${requestRate.toStringAsFixed(1)} req/s, successRate: ${calculatedSuccessRate.toStringAsFixed(1)}%)';
}

/// Value object for rate limiting statistics.
class RateLimitingStats extends Equatable {
  const RateLimitingStats({
    required this.activeRateLimits,
    required this.rateLimitViolations,
    required this.windowSize,
    this.maxRequestsPerWindow,
  });

  /// Number of active rate limits currently in effect
  final int activeRateLimits;

  /// Number of rate limit violations
  final int rateLimitViolations;

  /// Time window for rate limiting
  final Duration windowSize;

  /// Maximum requests allowed per window (optional)
  final int? maxRequestsPerWindow;

  /// Check if there are frequent violations
  bool get hasFrequentViolations => rateLimitViolations > 100;

  @override
  List<Object?> get props => [
        activeRateLimits,
        rateLimitViolations,
        windowSize,
        maxRequestsPerWindow,
      ];

  @override
  String toString() => 'RateLimitingStats(active: $activeRateLimits, '
      'violations: $rateLimitViolations)';
}
