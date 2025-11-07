import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/features/system_health/data/models/alert_model.dart';
import 'package:synapse_monitor/features/system_health/domain/entities/alert.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  group('AlertModel', () {
    final tAlertModel = AlertModel(
      id: 'alert-001',
      severity: 'critical',
      message: 'High error rate detected in authentication service',
      source: 'authentication-service',
      timestamp: DateTime.parse('2025-11-07T12:00:00Z'),
      isActive: true,
      acknowledgedAt: DateTime.parse('2025-11-07T12:15:00Z'),
      acknowledgedBy: 'admin@example.com',
      metadata: const {
        'errorCount': 150,
        'threshold': 100,
      },
    );

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Arrange
        final jsonMap =
            json.decode(fixture('alert.json')) as Map<String, dynamic>;

        // Act
        final result = AlertModel.fromJson(jsonMap);

        // Assert
        expect(result, equals(tAlertModel));
      });

      test('should handle missing optional fields', () {
        // Arrange
        final jsonMap = {
          'id': 'alert-001',
          'severity': 'warning',
          'message': 'Test alert',
          'source': 'test-service',
          'timestamp': '2025-11-07T12:00:00Z',
          'isActive': true,
        };

        // Act
        final result = AlertModel.fromJson(jsonMap);

        // Assert
        expect(result.id, equals('alert-001'));
        expect(result.acknowledgedAt, isNull);
        expect(result.acknowledgedBy, isNull);
        expect(result.metadata, isNull);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // Act
        final result = tAlertModel.toJson();

        // Assert
        final expectedMap = {
          'id': 'alert-001',
          'severity': 'critical',
          'message': 'High error rate detected in authentication service',
          'source': 'authentication-service',
          'timestamp': '2025-11-07T12:00:00.000Z',
          'isActive': true,
          'acknowledgedAt': '2025-11-07T12:15:00.000Z',
          'acknowledgedBy': 'admin@example.com',
          'metadata': {
            'errorCount': 150,
            'threshold': 100,
          },
        };

        expect(result, equals(expectedMap));
      });

      test('should handle null optional fields in JSON output', () {
        // Arrange
        final model = AlertModel(
          id: 'alert-002',
          severity: 'info',
          message: 'System started',
          source: 'system',
          timestamp: DateTime.parse('2025-11-07T12:00:00Z'),
          isActive: true,
          acknowledgedAt: null,
          acknowledgedBy: null,
          metadata: null,
        );

        // Act
        final result = model.toJson();

        // Assert
        expect(result['acknowledgedAt'], isNull);
        expect(result['acknowledgedBy'], isNull);
        expect(result['metadata'], isNull);
      });
    });

    group('toEntity', () {
      test('should convert model to Alert entity', () {
        // Act
        final result = tAlertModel.toEntity();

        // Assert
        expect(result, isA<Alert>());
        expect(result.id, equals('alert-001'));
        expect(result.severity, equals('critical'));
        expect(
          result.message,
          equals('High error rate detected in authentication service'),
        );
        expect(result.source, equals('authentication-service'));
        expect(
          result.timestamp,
          equals(DateTime.parse('2025-11-07T12:00:00Z')),
        );
        expect(result.isActive, isTrue);
        expect(
          result.acknowledgedAt,
          equals(DateTime.parse('2025-11-07T12:15:00Z')),
        );
        expect(result.acknowledgedBy, equals('admin@example.com'));
        expect(result.metadata, equals({
          'errorCount': 150,
          'threshold': 100,
        }));
      });

      test('should preserve entity computed properties', () {
        // Act
        final result = tAlertModel.toEntity();

        // Assert
        expect(result.isCritical, isTrue);
        expect(result.isWarning, isFalse);
        expect(result.isInfo, isFalse);
        expect(result.isAcknowledged, isTrue);
      });

      test('should handle different severity levels', () {
        // Arrange
        final warningModel = tAlertModel.copyWith(severity: 'warning');
        final infoModel = tAlertModel.copyWith(severity: 'info');

        // Act
        final warningResult = warningModel.toEntity();
        final infoResult = infoModel.toEntity();

        // Assert
        expect(warningResult.isWarning, isTrue);
        expect(warningResult.isCritical, isFalse);
        expect(infoResult.isInfo, isTrue);
        expect(infoResult.isCritical, isFalse);
      });
    });

    group('fromEntity', () {
      test('should create model from Alert entity', () {
        // Arrange
        final entity = Alert(
          id: 'alert-003',
          severity: 'warning',
          message: 'Memory usage high',
          source: 'monitoring-service',
          timestamp: DateTime.parse('2025-11-06T10:00:00Z'),
          isActive: false,
          acknowledgedAt: DateTime.parse('2025-11-06T10:30:00Z'),
          acknowledgedBy: 'user@example.com',
          metadata: const {'memoryUsage': '85%'},
        );

        // Act
        final result = AlertModel.fromEntity(entity);

        // Assert
        expect(result.id, equals('alert-003'));
        expect(result.severity, equals('warning'));
        expect(result.message, equals('Memory usage high'));
        expect(result.source, equals('monitoring-service'));
        expect(
          result.timestamp,
          equals(DateTime.parse('2025-11-06T10:00:00Z')),
        );
        expect(result.isActive, isFalse);
        expect(
          result.acknowledgedAt,
          equals(DateTime.parse('2025-11-06T10:30:00Z')),
        );
        expect(result.acknowledgedBy, equals('user@example.com'));
        expect(result.metadata, equals({'memoryUsage': '85%'}));
      });
    });

    group('copyWith', () {
      test('should return a new model with updated values', () {
        // Act
        final result = tAlertModel.copyWith(
          severity: 'warning',
          isActive: false,
          acknowledgedBy: 'different-admin@example.com',
        );

        // Assert
        expect(result.id, equals(tAlertModel.id));
        expect(result.severity, equals('warning'));
        expect(result.isActive, isFalse);
        expect(result.acknowledgedBy, equals('different-admin@example.com'));
        expect(result.message, equals(tAlertModel.message));
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final model1 = AlertModel(
          id: 'alert-001',
          severity: 'critical',
          message: 'Test',
          source: 'test',
          timestamp: DateTime.parse('2025-11-07T12:00:00Z'),
          isActive: true,
        );

        final model2 = AlertModel(
          id: 'alert-001',
          severity: 'critical',
          message: 'Test',
          source: 'test',
          timestamp: DateTime.parse('2025-11-07T12:00:00Z'),
          isActive: true,
        );

        // Assert
        expect(model1, equals(model2));
        expect(model1.hashCode, equals(model2.hashCode));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        final model1 = tAlertModel;
        final model2 = tAlertModel.copyWith(severity: 'warning');

        // Assert
        expect(model1, isNot(equals(model2)));
      });
    });
  });
}
