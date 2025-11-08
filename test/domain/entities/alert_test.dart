import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/domain/entities/alert.dart';

/// 🔴 RED PHASE - Alert Entity Tests

void main() {
  group('Alert Entity', () {
    const tId = 'alert-123';
    const tTitle = 'High CPU Usage';
    const tMessage = 'CPU usage has exceeded 90%';
    const tSeverity = AlertSeverity.warning;
    const tTimestamp = '2025-11-08T10:30:00Z';

    group('Constructor and Properties', () {
      test('should create Alert with all properties', () async {
        // This test will FAIL

        final alert = Alert(
          id: tId,
          title: tTitle,
          message: tMessage,
          severity: tSeverity,
          timestamp: DateTime.parse(tTimestamp),
          acknowledged: false,
        );

        expect(alert.id, tId);
        expect(alert.title, tTitle);
        expect(alert.message, tMessage);
        expect(alert.severity, tSeverity);
        expect(alert.acknowledged, false);
      });
    });

    group('Business Logic - Alert Status', () {
      test('should identify unacknowledged alerts', () async {
        // This test will FAIL

        final alert = Alert(
          id: tId,
          title: tTitle,
          message: tMessage,
          severity: tSeverity,
          timestamp: DateTime.parse(tTimestamp),
          acknowledged: false,
        );

        expect(alert.needsAttention, true);
      });

      test('should identify acknowledged alerts', () async {
        // This test will FAIL

        final alert = Alert(
          id: tId,
          title: tTitle,
          message: tMessage,
          severity: tSeverity,
          timestamp: DateTime.parse(tTimestamp),
          acknowledged: true,
        );

        expect(alert.needsAttention, false);
      });

      test('should calculate age of alert in minutes', () async {
        // This test will FAIL

        final oldTimestamp = DateTime.now().subtract(const Duration(minutes: 30));
        final alert = Alert(
          id: tId,
          title: tTitle,
          message: tMessage,
          severity: tSeverity,
          timestamp: oldTimestamp,
          acknowledged: false,
        );

        expect(alert.ageInMinutes, greaterThanOrEqualTo(30));
      });
    });

    group('Business Logic - Severity Classification', () {
      test('should identify critical alerts', () async {
        // This test will FAIL

        final alert = Alert(
          id: tId,
          title: tTitle,
          message: tMessage,
          severity: AlertSeverity.critical,
          timestamp: DateTime.parse(tTimestamp),
          acknowledged: false,
        );

        expect(alert.isCritical, true);
      });

      test('should get severity color for UI', () async {
        // This test will FAIL

        final criticalAlert = Alert(
          id: tId,
          title: tTitle,
          message: tMessage,
          severity: AlertSeverity.critical,
          timestamp: DateTime.parse(tTimestamp),
          acknowledged: false,
        );

        expect(criticalAlert.severityColor, isA<String>());
      });
    });

    group('CopyWith', () {
      test('should create copy with acknowledged status updated', () async {
        // This test will FAIL

        final original = Alert(
          id: tId,
          title: tTitle,
          message: tMessage,
          severity: tSeverity,
          timestamp: DateTime.parse(tTimestamp),
          acknowledged: false,
        );

        final acknowledged = original.copyWith(acknowledged: true);

        expect(acknowledged.acknowledged, true);
        expect(acknowledged.id, original.id);
      });
    });
  });
}
