import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/core/utils/date_time_utils.dart';

/// 🔴 RED PHASE - DateTimeUtils Tests

void main() {
  group('DateTimeUtils', () {
    group('formatDateTime', () {
      test('should format DateTime to readable string', () async {
        // This test will FAIL

        final dateTime = DateTime(2025, 11, 8, 14, 30, 0);

        final result = DateTimeUtils.formatDateTime(dateTime);

        expect(result, '2025-11-08 14:30');
      });

      test('should format with custom pattern', () async {
        // This test will FAIL

        final dateTime = DateTime(2025, 11, 8, 14, 30, 0);

        final result = DateTimeUtils.formatDateTime(
          dateTime,
          pattern: 'MMM dd, yyyy',
        );

        expect(result, 'Nov 08, 2025');
      });
    });

    group('formatTimeAgo', () {
      test('should return "just now" for recent timestamps', () async {
        // This test will FAIL

        final now = DateTime.now();
        final recent = now.subtract(const Duration(seconds: 10));

        final result = DateTimeUtils.formatTimeAgo(recent);

        expect(result, 'just now');
      });

      test('should return "X minutes ago" for minutes', () async {
        // This test will FAIL

        final now = DateTime.now();
        final past = now.subtract(const Duration(minutes: 5));

        final result = DateTimeUtils.formatTimeAgo(past);

        expect(result, '5 minutes ago');
      });

      test('should return "X hours ago" for hours', () async {
        // This test will FAIL

        final now = DateTime.now();
        final past = now.subtract(const Duration(hours: 3));

        final result = DateTimeUtils.formatTimeAgo(past);

        expect(result, '3 hours ago');
      });

      test('should return "X days ago" for days', () async {
        // This test will FAIL

        final now = DateTime.now();
        final past = now.subtract(const Duration(days: 2));

        final result = DateTimeUtils.formatTimeAgo(past);

        expect(result, '2 days ago');
      });

      test('should return "X weeks ago" for weeks', () async {
        // This test will FAIL

        final now = DateTime.now();
        final past = now.subtract(const Duration(days: 14));

        final result = DateTimeUtils.formatTimeAgo(past);

        expect(result, '2 weeks ago');
      });
    });

    group('getDuration', () {
      test('should calculate duration between two timestamps', () async {
        // This test will FAIL

        final start = DateTime(2025, 11, 8, 10, 0, 0);
        final end = DateTime(2025, 11, 8, 12, 30, 0);

        final result = DateTimeUtils.getDuration(start, end);

        expect(result.inHours, 2);
        expect(result.inMinutes, 150);
      });

      test('should handle negative duration when end is before start', () async {
        // This test will FAIL

        final start = DateTime(2025, 11, 8, 12, 0, 0);
        final end = DateTime(2025, 11, 8, 10, 0, 0);

        final result = DateTimeUtils.getDuration(start, end);

        expect(result.isNegative, true);
      });
    });

    group('formatDuration', () {
      test('should format duration as human-readable string', () async {
        // This test will FAIL

        const duration = Duration(hours: 2, minutes: 30, seconds: 45);

        final result = DateTimeUtils.formatDuration(duration);

        expect(result, '2h 30m 45s');
      });

      test('should format short durations', () async {
        // This test will FAIL

        const duration = Duration(seconds: 45);

        final result = DateTimeUtils.formatDuration(duration);

        expect(result, '45s');
      });

      test('should format durations with days', () async {
        // This test will FAIL

        const duration = Duration(days: 3, hours: 5);

        final result = DateTimeUtils.formatDuration(duration);

        expect(result, '3d 5h');
      });
    });

    group('isToday', () {
      test('should return true for today\'s date', () async {
        // This test will FAIL

        final today = DateTime.now();

        final result = DateTimeUtils.isToday(today);

        expect(result, true);
      });

      test('should return false for yesterday', () async {
        // This test will FAIL

        final yesterday = DateTime.now().subtract(const Duration(days: 1));

        final result = DateTimeUtils.isToday(yesterday);

        expect(result, false);
      });
    });

    group('isSameDay', () {
      test('should return true for same day', () async {
        // This test will FAIL

        final date1 = DateTime(2025, 11, 8, 10, 0, 0);
        final date2 = DateTime(2025, 11, 8, 15, 30, 0);

        final result = DateTimeUtils.isSameDay(date1, date2);

        expect(result, true);
      });

      test('should return false for different days', () async {
        // This test will FAIL

        final date1 = DateTime(2025, 11, 8, 10, 0, 0);
        final date2 = DateTime(2025, 11, 9, 10, 0, 0);

        final result = DateTimeUtils.isSameDay(date1, date2);

        expect(result, false);
      });
    });

    group('startOfDay', () {
      test('should return start of day (midnight)', () async {
        // This test will FAIL

        final dateTime = DateTime(2025, 11, 8, 14, 30, 45);

        final result = DateTimeUtils.startOfDay(dateTime);

        expect(result.hour, 0);
        expect(result.minute, 0);
        expect(result.second, 0);
        expect(result.millisecond, 0);
      });
    });

    group('endOfDay', () {
      test('should return end of day (23:59:59)', () async {
        // This test will FAIL

        final dateTime = DateTime(2025, 11, 8, 14, 30, 45);

        final result = DateTimeUtils.endOfDay(dateTime);

        expect(result.hour, 23);
        expect(result.minute, 59);
        expect(result.second, 59);
      });
    });
  });
}
