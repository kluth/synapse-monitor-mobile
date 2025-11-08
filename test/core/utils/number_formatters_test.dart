import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/core/utils/number_formatters.dart';

/// 🔴 RED PHASE - NumberFormatters Tests

void main() {
  group('NumberFormatters', () {
    group('formatPercentage', () {
      test('should format number as percentage', () async {
        // This test will FAIL

        expect(NumberFormatters.formatPercentage(0.75), '75.0%');
        expect(NumberFormatters.formatPercentage(0.5), '50.0%');
        expect(NumberFormatters.formatPercentage(1.0), '100.0%');
      });

      test('should format with custom decimal places', () async {
        // This test will FAIL

        expect(NumberFormatters.formatPercentage(0.7532, decimals: 2), '75.32%');
        expect(NumberFormatters.formatPercentage(0.7532, decimals: 0), '75%');
      });
    });

    group('formatDecimal', () {
      test('should format decimal with specified places', () async {
        // This test will FAIL

        expect(NumberFormatters.formatDecimal(3.14159, decimals: 2), '3.14');
        expect(NumberFormatters.formatDecimal(2.5, decimals: 1), '2.5');
      });

      test('should handle large numbers', () async {
        // This test will FAIL

        expect(NumberFormatters.formatDecimal(123456.789, decimals: 2), '123,456.79');
      });
    });

    group('formatCompact', () {
      test('should format large numbers compactly', () async {
        // This test will FAIL

        expect(NumberFormatters.formatCompact(1000), '1K');
        expect(NumberFormatters.formatCompact(1500), '1.5K');
        expect(NumberFormatters.formatCompact(1000000), '1M');
        expect(NumberFormatters.formatCompact(1500000), '1.5M');
        expect(NumberFormatters.formatCompact(1000000000), '1B');
      });

      test('should not format small numbers', () async {
        // This test will FAIL

        expect(NumberFormatters.formatCompact(999), '999');
        expect(NumberFormatters.formatCompact(500), '500');
      });
    });

    group('formatBytes', () {
      test('should format bytes to human-readable format', () async {
        // This test will FAIL

        expect(NumberFormatters.formatBytes(1024), '1.0 KB');
        expect(NumberFormatters.formatBytes(1048576), '1.0 MB');
        expect(NumberFormatters.formatBytes(1073741824), '1.0 GB');
      });

      test('should handle bytes less than 1 KB', () async {
        // This test will FAIL

        expect(NumberFormatters.formatBytes(512), '512 B');
        expect(NumberFormatters.formatBytes(100), '100 B');
      });
    });

    group('formatDuration', () {
      test('should format seconds to duration', () async {
        // This test will FAIL

        expect(NumberFormatters.formatDurationSeconds(3661), '1h 1m 1s');
        expect(NumberFormatters.formatDurationSeconds(90), '1m 30s');
        expect(NumberFormatters.formatDurationSeconds(45), '45s');
      });

      test('should handle zero duration', () async {
        // This test will FAIL

        expect(NumberFormatters.formatDurationSeconds(0), '0s');
      });
    });

    group('formatCurrency', () {
      test('should format number as currency', () async {
        // This test will FAIL

        expect(NumberFormatters.formatCurrency(1234.56), r'$1,234.56');
        expect(NumberFormatters.formatCurrency(99.99), r'$99.99');
      });

      test('should handle custom currency symbol', () async {
        // This test will FAIL

        expect(NumberFormatters.formatCurrency(100, symbol: '€'), '€100.00');
      });
    });

    group('roundToDecimal', () {
      test('should round to specified decimal places', () async {
        // This test will FAIL

        expect(NumberFormatters.roundToDecimal(3.14159, decimals: 2), 3.14);
        expect(NumberFormatters.roundToDecimal(2.5678, decimals: 1), 2.6);
      });
    });

    group('clamp', () {
      test('should clamp value between min and max', () async {
        // This test will FAIL

        expect(NumberFormatters.clamp(5, min: 0, max: 10), 5);
        expect(NumberFormatters.clamp(-5, min: 0, max: 10), 0);
        expect(NumberFormatters.clamp(15, min: 0, max: 10), 10);
      });
    });

    group('normalize', () {
      test('should normalize value to 0-1 range', () async {
        // This test will FAIL

        expect(NumberFormatters.normalize(50, min: 0, max: 100), 0.5);
        expect(NumberFormatters.normalize(75, min: 0, max: 100), 0.75);
        expect(NumberFormatters.normalize(0, min: 0, max: 100), 0.0);
      });
    });

    group('parseFormattedNumber', () {
      test('should parse formatted number string', () async {
        // This test will FAIL

        expect(NumberFormatters.parseFormattedNumber('1,234.56'), 1234.56);
        expect(NumberFormatters.parseFormattedNumber('75.32%'), 0.7532);
      });
    });
  });
}
