import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/domain/entities/error_log.dart';

/// 🔴 RED PHASE - ErrorLog Entity Tests

void main() {
  group('ErrorLog Entity', () {
    const tId = 'error-123';
    const tMessage = 'Connection timeout';
    const tErrorCode = 'CONN_TIMEOUT';
    const tStackTrace = 'at Connection.connect...';
    const tTimestamp = '2025-11-08T10:30:00Z';

    group('Constructor and Properties', () {
      test('should create ErrorLog with all properties', () async {
        // This test will FAIL

        final errorLog = ErrorLog(
          id: tId,
          message: tMessage,
          errorCode: tErrorCode,
          severity: ErrorSeverity.error,
          stackTrace: tStackTrace,
          timestamp: DateTime.parse(tTimestamp),
        );

        expect(errorLog.id, tId);
        expect(errorLog.message, tMessage);
        expect(errorLog.errorCode, tErrorCode);
        expect(errorLog.severity, ErrorSeverity.error);
        expect(errorLog.stackTrace, tStackTrace);
      });
    });

    group('Business Logic - Severity Classification', () {
      test('should identify critical errors', () async {
        // This test will FAIL

        final errorLog = ErrorLog(
          id: tId,
          message: tMessage,
          errorCode: tErrorCode,
          severity: ErrorSeverity.critical,
          timestamp: DateTime.parse(tTimestamp),
        );

        expect(errorLog.isCritical, true);
      });

      test('should get severity level as integer', () async {
        // This test will FAIL

        final errorLog = ErrorLog(
          id: tId,
          message: tMessage,
          errorCode: tErrorCode,
          severity: ErrorSeverity.error,
          timestamp: DateTime.parse(tTimestamp),
        );

        expect(errorLog.severityLevel, greaterThan(0));
      });
    });

    group('Business Logic - Error Categorization', () {
      test('should identify network errors by error code', () async {
        // This test will FAIL

        final errorLog = ErrorLog(
          id: tId,
          message: tMessage,
          errorCode: 'NETWORK_ERROR',
          severity: ErrorSeverity.error,
          timestamp: DateTime.parse(tTimestamp),
        );

        expect(errorLog.isNetworkError, true);
      });

      test('should identify validation errors by error code', () async {
        // This test will FAIL

        final errorLog = ErrorLog(
          id: tId,
          message: tMessage,
          errorCode: 'VALIDATION_FAILED',
          severity: ErrorSeverity.warning,
          timestamp: DateTime.parse(tTimestamp),
        );

        expect(errorLog.isValidationError, true);
      });
    });

    group('Business Logic - Age Calculation', () {
      test('should calculate age in minutes', () async {
        // This test will FAIL

        final oldTimestamp = DateTime.now().subtract(const Duration(minutes: 45));
        final errorLog = ErrorLog(
          id: tId,
          message: tMessage,
          errorCode: tErrorCode,
          severity: ErrorSeverity.error,
          timestamp: oldTimestamp,
        );

        expect(errorLog.ageInMinutes, greaterThanOrEqualTo(45));
      });

      test('should identify recent errors (< 5 minutes)', () async {
        // This test will FAIL

        final recentTimestamp = DateTime.now().subtract(const Duration(minutes: 2));
        final errorLog = ErrorLog(
          id: tId,
          message: tMessage,
          errorCode: tErrorCode,
          severity: ErrorSeverity.error,
          timestamp: recentTimestamp,
        );

        expect(errorLog.isRecent, true);
      });
    });

    group('Formatting', () {
      test('should format error for display', () async {
        // This test will FAIL

        final errorLog = ErrorLog(
          id: tId,
          message: tMessage,
          errorCode: tErrorCode,
          severity: ErrorSeverity.error,
          timestamp: DateTime.parse(tTimestamp),
        );

        final formatted = errorLog.formattedMessage;
        expect(formatted, contains(tErrorCode));
        expect(formatted, contains(tMessage));
      });
    });
  });
}
