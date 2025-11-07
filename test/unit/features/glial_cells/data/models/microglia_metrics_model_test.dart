import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/features/glial_cells/data/models/microglia_metrics_model.dart';
import 'package:synapse_monitor/features/glial_cells/domain/entities/microglia_metrics.dart';
import 'package:synapse_monitor/features/system_health/data/models/alert_model.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  group('MicrogliaMetricsModel', () {
    final tAlerts = [
      AlertModel(
        id: 'alert-001',
        severity: 'critical',
        message: 'Payment service down',
        source: 'payment-service',
        timestamp: DateTime.parse('2025-11-07T11:00:00Z'),
        isActive: true,
      ),
      AlertModel(
        id: 'alert-002',
        severity: 'warning',
        message: 'High error rate',
        source: 'auth-service',
        timestamp: DateTime.parse('2025-11-07T11:30:00Z'),
        isActive: false,
        acknowledgedAt: DateTime.parse('2025-11-07T11:45:00Z'),
        acknowledgedBy: 'admin@example.com',
      ),
    ];

    final tMicrogliaMetricsModel = MicrogliaMetricsModel(
      errorCounts: const {
        'auth-service': 25,
        'user-service': 15,
        'payment-service': 10,
      },
      errorRate: 5.5,
      customMetrics: const {
        'cpu_usage': 75.5,
        'memory_usage': 65.2,
        'disk_io': 120.8,
      },
      healthChecks: const {
        'auth-service': true,
        'user-service': true,
        'payment-service': false,
      },
      alertHistory: tAlerts,
      systemHealthScore: 72.5,
      thresholdBreaches: 3,
      monitoredServices: const ['auth-service', 'user-service', 'payment-service'],
      timestamp: DateTime.parse('2025-11-07T12:00:00Z'),
    );

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Arrange
        final jsonMap = json.decode(fixture('microglia_metrics.json'))
            as Map<String, dynamic>;

        // Act
        final result = MicrogliaMetricsModel.fromJson(jsonMap);

        // Assert
        expect(result, equals(tMicrogliaMetricsModel));
      });

      test('should handle missing optional fields', () {
        // Arrange
        final jsonMap = {
          'errorCounts': {'test-service': 10},
          'errorRate': 2.0,
          'customMetrics': {'cpu': 50.0},
          'healthChecks': {'test-service': true},
          'alertHistory': [],
          'systemHealthScore': 80.0,
          'thresholdBreaches': 0,
        };

        // Act
        final result = MicrogliaMetricsModel.fromJson(jsonMap);

        // Assert
        expect(result.errorCounts, equals({'test-service': 10}));
        expect(result.monitoredServices, isNull);
        expect(result.timestamp, isNull);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // Act
        final result = tMicrogliaMetricsModel.toJson();

        // Assert
        expect(result['errorCounts'], equals({
          'auth-service': 25,
          'user-service': 15,
          'payment-service': 10,
        }));
        expect(result['errorRate'], equals(5.5));
        expect(result['systemHealthScore'], equals(72.5));
        expect(result['thresholdBreaches'], equals(3));
        expect(result['timestamp'], equals('2025-11-07T12:00:00.000Z'));
        expect(result['alertHistory'], isList);
        expect(result['alertHistory'].length, equals(2));
      });

      test('should properly serialize nested alert models', () {
        // Act
        final result = tMicrogliaMetricsModel.toJson();

        // Assert
        final alerts = result['alertHistory'] as List;
        expect(alerts[0]['id'], equals('alert-001'));
        expect(alerts[0]['severity'], equals('critical'));
        expect(alerts[1]['id'], equals('alert-002'));
        expect(alerts[1]['severity'], equals('warning'));
      });
    });

    group('toEntity', () {
      test('should convert model to MicrogliaMetrics entity', () {
        // Act
        final result = tMicrogliaMetricsModel.toEntity();

        // Assert
        expect(result, isA<MicrogliaMetrics>());
        expect(result.errorCounts, equals({
          'auth-service': 25,
          'user-service': 15,
          'payment-service': 10,
        }));
        expect(result.errorRate, equals(5.5));
        expect(result.customMetrics, equals({
          'cpu_usage': 75.5,
          'memory_usage': 65.2,
          'disk_io': 120.8,
        }));
        expect(result.healthChecks, equals({
          'auth-service': true,
          'user-service': true,
          'payment-service': false,
        }));
        expect(result.systemHealthScore, equals(72.5));
        expect(result.thresholdBreaches, equals(3));
        expect(
          result.monitoredServices,
          equals(['auth-service', 'user-service', 'payment-service']),
        );
        expect(
          result.timestamp,
          equals(DateTime.parse('2025-11-07T12:00:00Z')),
        );
        expect(result.alertHistory.length, equals(2));
      });

      test('should properly convert nested alert models to entities', () {
        // Act
        final result = tMicrogliaMetricsModel.toEntity();

        // Assert
        expect(result.alertHistory[0].id, equals('alert-001'));
        expect(result.alertHistory[0].severity, equals('critical'));
        expect(result.alertHistory[0].isActive, isTrue);
        expect(result.alertHistory[1].id, equals('alert-002'));
        expect(result.alertHistory[1].severity, equals('warning'));
        expect(result.alertHistory[1].isActive, isFalse);
      });

      test('should preserve entity computed properties', () {
        // Act
        final result = tMicrogliaMetricsModel.toEntity();

        // Assert
        // totalErrors = 25 + 15 + 10 = 50
        expect(result.totalErrors, equals(50));
        // healthyServicesCount = 2 (auth + user)
        expect(result.healthyServicesCount, equals(2));
        // unhealthyServicesCount = 1 (payment)
        expect(result.unhealthyServicesCount, equals(1));
        expect(result.totalServicesCount, equals(3));
        // serviceHealthPercentage = (2 / 3) * 100 = 66.67%
        expect(result.serviceHealthPercentage, closeTo(66.67, 0.01));
        expect(result.isCriticalHealth, isFalse); // 72.5 >= 50
        expect(result.isWarningHealth, isTrue); // 50 <= 72.5 < 70... wait, 72.5 >= 70
        expect(result.isGoodHealth, isTrue); // 72.5 >= 70
        expect(result.hasHighErrorRate, isFalse); // 5.5 <= 10
        expect(result.activeAlerts.length, equals(1));
        expect(result.criticalAlerts.length, equals(1));
        expect(result.mostErroredService, equals('auth-service'));
        expect(result.hasUnhealthyServices, isTrue);
        expect(result.hasRecentBreaches, isTrue);
      });
    });

    group('fromEntity', () {
      test('should create model from MicrogliaMetrics entity', () {
        // Arrange
        final entity = MicrogliaMetrics(
          errorCounts: const {'test': 5},
          errorRate: 1.0,
          customMetrics: const {'metric': 10.0},
          healthChecks: const {'test': true},
          alertHistory: [tAlerts[0].toEntity()],
          systemHealthScore: 85.0,
          thresholdBreaches: 1,
          monitoredServices: const ['test'],
          timestamp: DateTime.parse('2025-11-06T10:00:00Z'),
        );

        // Act
        final result = MicrogliaMetricsModel.fromEntity(entity);

        // Assert
        expect(result.errorCounts, equals({'test': 5}));
        expect(result.errorRate, equals(1.0));
        expect(result.systemHealthScore, equals(85.0));
        expect(result.thresholdBreaches, equals(1));
        expect(result.monitoredServices, equals(['test']));
        expect(
          result.timestamp,
          equals(DateTime.parse('2025-11-06T10:00:00Z')),
        );
        expect(result.alertHistory.length, equals(1));
      });
    });

    group('copyWith', () {
      test('should return a new model with updated values', () {
        // Act
        final result = tMicrogliaMetricsModel.copyWith(
          errorRate: 10.0,
          systemHealthScore: 85.0,
          thresholdBreaches: 5,
        );

        // Assert
        expect(result.errorCounts, equals(tMicrogliaMetricsModel.errorCounts));
        expect(result.errorRate, equals(10.0));
        expect(result.systemHealthScore, equals(85.0));
        expect(result.thresholdBreaches, equals(5));
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final model1 = MicrogliaMetricsModel(
          errorCounts: const {'test': 10},
          errorRate: 2.0,
          customMetrics: const {'cpu': 50.0},
          healthChecks: const {'test': true},
          alertHistory: const [],
          systemHealthScore: 80.0,
          thresholdBreaches: 0,
        );

        final model2 = MicrogliaMetricsModel(
          errorCounts: const {'test': 10},
          errorRate: 2.0,
          customMetrics: const {'cpu': 50.0},
          healthChecks: const {'test': true},
          alertHistory: const [],
          systemHealthScore: 80.0,
          thresholdBreaches: 0,
        );

        // Assert
        expect(model1, equals(model2));
        expect(model1.hashCode, equals(model2.hashCode));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        final model1 = tMicrogliaMetricsModel;
        final model2 = tMicrogliaMetricsModel.copyWith(errorRate: 15.0);

        // Assert
        expect(model1, isNot(equals(model2)));
      });
    });
  });
}
