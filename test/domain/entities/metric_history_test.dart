import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/domain/entities/metric_history.dart';

/// 🔴 RED PHASE - MetricHistory Entity Tests

void main() {
  group('MetricHistory Entity', () {
    const tMetricName = 'cpu_usage';
    final tDataPoints = [
      DataPoint(timestamp: DateTime.parse('2025-11-08T10:00:00Z'), value: 45.0),
      DataPoint(timestamp: DateTime.parse('2025-11-08T10:05:00Z'), value: 52.0),
      DataPoint(timestamp: DateTime.parse('2025-11-08T10:10:00Z'), value: 48.0),
    ];

    group('Constructor and Properties', () {
      test('should create MetricHistory with all properties', () async {
        // This test will FAIL

        final history = MetricHistory(
          metricName: tMetricName,
          dataPoints: tDataPoints,
          unit: '%',
        );

        expect(history.metricName, tMetricName);
        expect(history.dataPoints, tDataPoints);
        expect(history.unit, '%');
      });
    });

    group('Business Logic - Statistics', () {
      test('should calculate average value', () async {
        // This test will FAIL

        final history = MetricHistory(
          metricName: tMetricName,
          dataPoints: tDataPoints,
          unit: '%',
        );

        expect(history.average, closeTo(48.33, 0.1));
      });

      test('should find minimum value', () async {
        // This test will FAIL

        final history = MetricHistory(
          metricName: tMetricName,
          dataPoints: tDataPoints,
          unit: '%',
        );

        expect(history.minimum, 45.0);
      });

      test('should find maximum value', () async {
        // This test will FAIL

        final history = MetricHistory(
          metricName: tMetricName,
          dataPoints: tDataPoints,
          unit: '%',
        );

        expect(history.maximum, 52.0);
      });

      test('should calculate trend direction', () async {
        // This test will FAIL

        final history = MetricHistory(
          metricName: tMetricName,
          dataPoints: tDataPoints,
          unit: '%',
        );

        expect(history.trend, TrendDirection.stable);
      });
    });

    group('Business Logic - Time Range', () {
      test('should get data points for specific time range', () async {
        // This test will FAIL

        final history = MetricHistory(
          metricName: tMetricName,
          dataPoints: tDataPoints,
          unit: '%',
        );

        final start = DateTime.parse('2025-11-08T10:05:00Z');
        final end = DateTime.parse('2025-11-08T10:10:00Z');
        final filtered = history.getDataPointsInRange(start, end);

        expect(filtered, hasLength(2));
      });

      test('should get latest value', () async {
        // This test will FAIL

        final history = MetricHistory(
          metricName: tMetricName,
          dataPoints: tDataPoints,
          unit: '%',
        );

        expect(history.latestValue, 48.0);
      });
    });
  });

  group('DataPoint Entity', () {
    test('should create DataPoint with timestamp and value', () async {
      // This test will FAIL

      final dataPoint = DataPoint(
        timestamp: DateTime.parse('2025-11-08T10:00:00Z'),
        value: 45.5,
      );

      expect(dataPoint.timestamp, DateTime.parse('2025-11-08T10:00:00Z'));
      expect(dataPoint.value, 45.5);
    });

    test('should compare DataPoints by timestamp', () async {
      // This test will FAIL

      final point1 = DataPoint(
        timestamp: DateTime.parse('2025-11-08T10:00:00Z'),
        value: 45.0,
      );

      final point2 = DataPoint(
        timestamp: DateTime.parse('2025-11-08T11:00:00Z'),
        value: 50.0,
      );

      expect(point1.isBefore(point2), true);
    });
  });
}
