import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/core/utils/validators.dart';

/// 🔴 RED PHASE - Validators Tests

void main() {
  group('Validators', () {
    group('isValidWeight', () {
      test('should return true for valid weight in range 0-1', () async {
        // This test will FAIL

        expect(Validators.isValidWeight(0.5), true);
        expect(Validators.isValidWeight(0.0), true);
        expect(Validators.isValidWeight(1.0), true);
      });

      test('should return false for weight outside range', () async {
        // This test will FAIL

        expect(Validators.isValidWeight(-0.1), false);
        expect(Validators.isValidWeight(1.5), false);
        expect(Validators.isValidWeight(2.0), false);
      });
    });

    group('isValidThreshold', () {
      test('should return true for valid threshold in range 0-1', () async {
        // This test will FAIL

        expect(Validators.isValidThreshold(0.75), true);
        expect(Validators.isValidThreshold(0.0), true);
        expect(Validators.isValidThreshold(1.0), true);
      });

      test('should return false for invalid threshold', () async {
        // This test will FAIL

        expect(Validators.isValidThreshold(-0.5), false);
        expect(Validators.isValidThreshold(1.1), false);
      });
    });

    group('isValidPercentage', () {
      test('should return true for valid percentage 0-100', () async {
        // This test will FAIL

        expect(Validators.isValidPercentage(50.0), true);
        expect(Validators.isValidPercentage(0.0), true);
        expect(Validators.isValidPercentage(100.0), true);
      });

      test('should return false for invalid percentage', () async {
        // This test will FAIL

        expect(Validators.isValidPercentage(-10.0), false);
        expect(Validators.isValidPercentage(150.0), false);
      });
    });

    group('isValidId', () {
      test('should return true for non-empty ID strings', () async {
        // This test will FAIL

        expect(Validators.isValidId('neuron-123'), true);
        expect(Validators.isValidId('synapse-456'), true);
      });

      test('should return false for empty or whitespace IDs', () async {
        // This test will FAIL

        expect(Validators.isValidId(''), false);
        expect(Validators.isValidId('   '), false);
      });

      test('should return false for null IDs', () async {
        // This test will FAIL

        expect(Validators.isValidId(null), false);
      });
    });

    group('isValidConnectionCount', () {
      test('should return true for non-negative connection counts', () async {
        // This test will FAIL

        expect(Validators.isValidConnectionCount(0), true);
        expect(Validators.isValidConnectionCount(10), true);
        expect(Validators.isValidConnectionCount(1000), true);
      });

      test('should return false for negative connection counts', () async {
        // This test will FAIL

        expect(Validators.isValidConnectionCount(-1), false);
        expect(Validators.isValidConnectionCount(-100), false);
      });
    });

    group('isValidErrorRate', () {
      test('should return true for error rate in range 0-1', () async {
        // This test will FAIL

        expect(Validators.isValidErrorRate(0.05), true);
        expect(Validators.isValidErrorRate(0.0), true);
        expect(Validators.isValidErrorRate(1.0), true);
      });

      test('should return false for error rate outside range', () async {
        // This test will FAIL

        expect(Validators.isValidErrorRate(-0.1), false);
        expect(Validators.isValidErrorRate(1.5), false);
      });
    });

    group('isValidUptime', () {
      test('should return true for non-negative uptime', () async {
        // This test will FAIL

        expect(Validators.isValidUptime(0), true);
        expect(Validators.isValidUptime(86400), true);
        expect(Validators.isValidUptime(999999), true);
      });

      test('should return false for negative uptime', () async {
        // This test will FAIL

        expect(Validators.isValidUptime(-1), false);
      });
    });

    group('sanitizeInput', () {
      test('should trim whitespace from input', () async {
        // This test will FAIL

        expect(Validators.sanitizeInput('  hello  '), 'hello');
        expect(Validators.sanitizeInput('test'), 'test');
      });

      test('should remove special characters if specified', () async {
        // This test will FAIL

        expect(
          Validators.sanitizeInput('hello@world!', removeSpecialChars: true),
          'helloworld',
        );
      });
    });

    group('isValidTimeRange', () {
      test('should return true for valid time range', () async {
        // This test will FAIL

        final start = DateTime(2025, 11, 8, 10, 0, 0);
        final end = DateTime(2025, 11, 8, 12, 0, 0);

        expect(Validators.isValidTimeRange(start, end), true);
      });

      test('should return false when start is after end', () async {
        // This test will FAIL

        final start = DateTime(2025, 11, 8, 12, 0, 0);
        final end = DateTime(2025, 11, 8, 10, 0, 0);

        expect(Validators.isValidTimeRange(start, end), false);
      });

      test('should return true when start equals end', () async {
        // This test will FAIL

        final dateTime = DateTime(2025, 11, 8, 10, 0, 0);

        expect(Validators.isValidTimeRange(dateTime, dateTime), true);
      });
    });

    group('isValidLimit', () {
      test('should return true for positive limit values', () async {
        // This test will FAIL

        expect(Validators.isValidLimit(1), true);
        expect(Validators.isValidLimit(100), true);
        expect(Validators.isValidLimit(1000), true);
      });

      test('should return false for zero or negative limits', () async {
        // This test will FAIL

        expect(Validators.isValidLimit(0), false);
        expect(Validators.isValidLimit(-1), false);
      });

      test('should return false for limits exceeding max', () async {
        // This test will FAIL

        expect(Validators.isValidLimit(10000, max: 1000), false);
        expect(Validators.isValidLimit(500, max: 1000), true);
      });
    });
  });
}
