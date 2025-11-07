import 'package:equatable/equatable.dart';

/// Entity representing a single metric data point for time-series data.
///
/// Used for tracking metrics over time, such as neuron performance,
/// system health scores, error rates, etc.
class MetricDataPoint extends Equatable {
  const MetricDataPoint({
    required this.timestamp,
    required this.value,
    this.label,
    this.metadata,
  });

  /// When this data point was recorded
  final DateTime timestamp;

  /// The metric value
  final double value;

  /// Optional label for the data point
  final String? label;

  /// Optional metadata
  final Map<String, dynamic>? metadata;

  /// Check if data point is recent (within last hour)
  bool get isRecent {
    final now = DateTime.now();
    final oneHourAgo = now.subtract(const Duration(hours: 1));
    return timestamp.isAfter(oneHourAgo);
  }

  /// Get age of this data point
  Duration get age {
    return DateTime.now().difference(timestamp);
  }

  @override
  List<Object?> get props => [timestamp, value, label, metadata];

  @override
  String toString() => 'MetricDataPoint(timestamp: $timestamp, value: $value)';
}

/// Extension for list of metric data points
extension MetricDataPointListExtension on List<MetricDataPoint> {
  /// Get average value
  double get average {
    if (isEmpty) {
      return 0.0;
    }
    final sum = fold<double>(0.0, (prev, point) => prev + point.value);
    return sum / length;
  }

  /// Get minimum value
  double get min {
    if (isEmpty) {
      return 0.0;
    }
    return map((point) => point.value).reduce((a, b) => a < b ? a : b);
  }

  /// Get maximum value
  double get max {
    if (isEmpty) {
      return 0.0;
    }
    return map((point) => point.value).reduce((a, b) => a > b ? a : b);
  }

  /// Get most recent value
  double? get latest {
    if (isEmpty) {
      return null;
    }
    // Sort by timestamp descending and get first
    final sorted = List<MetricDataPoint>.from(this)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sorted.first.value;
  }

  /// Get trend (positive = increasing, negative = decreasing, 0 = stable)
  double get trend {
    if (length < 2) {
      return 0.0;
    }

    final sorted = List<MetricDataPoint>.from(this)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    final first = sorted.first.value;
    final last = sorted.last.value;

    if (first == 0) {
      return last > 0 ? 1.0 : 0.0;
    }

    return ((last - first) / first) * 100; // Percentage change
  }

  /// Filter data points within a time range
  List<MetricDataPoint> filterByTimeRange(DateTime start, DateTime end) {
    return where((point) =>
        point.timestamp.isAfter(start) && point.timestamp.isBefore(end)).toList();
  }

  /// Group data points by time interval (e.g., hourly, daily)
  Map<DateTime, List<MetricDataPoint>> groupByInterval(Duration interval) {
    final groups = <DateTime, List<MetricDataPoint>>{};

    for (final point in this) {
      // Round down to interval
      final intervalStart = DateTime.fromMillisecondsSinceEpoch(
        (point.timestamp.millisecondsSinceEpoch ~/ interval.inMilliseconds) *
            interval.inMilliseconds,
      );

      groups.putIfAbsent(intervalStart, () => []).add(point);
    }

    return groups;
  }
}
