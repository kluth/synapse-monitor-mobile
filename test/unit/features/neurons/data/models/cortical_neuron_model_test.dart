import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/features/neurons/data/models/cortical_neuron_model.dart';
import 'package:synapse_monitor/features/neurons/domain/entities/cortical_neuron.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  group('CorticalNeuronModel', () {
    final tCorticalNeuronModel = CorticalNeuronModel(
      id: 'cortical-456',
      name: 'Authentication Service',
      type: 'cortical',
      status: 'active',
      activationThreshold: 0.85,
      processedSignalCount: 5000,
      averageProcessingTimeMs: 150,
      lastActiveAt: DateTime.parse('2025-11-07T12:00:00Z'),
      description: 'Stateful auth service with session management',
      metadata: {
        'version': '2.1.0',
        'region': 'us-east-1',
      },
      stateSize: 2048576,
      stateChanges: 342,
      uptimeMs: 7200000,
      restartCount: 2,
      currentState: {
        'activeSessions': 127,
        'cacheSize': 1024,
      },
    );

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Arrange
        final jsonMap = json.decode(fixture('cortical_neuron.json'))
            as Map<String, dynamic>;

        // Act
        final result = CorticalNeuronModel.fromJson(jsonMap);

        // Assert
        expect(result, equals(tCorticalNeuronModel));
      });

      test('should handle missing optional fields', () {
        // Arrange
        final jsonMap = {
          'id': 'cortical-456',
          'name': 'Authentication Service',
          'type': 'cortical',
          'status': 'active',
          'activationThreshold': 0.85,
          'processedSignalCount': 5000,
          'averageProcessingTimeMs': 150,
          'lastActiveAt': '2025-11-07T12:00:00Z',
          'stateSize': 2048576,
          'stateChanges': 342,
          'uptimeMs': 7200000,
          'restartCount': 2,
        };

        // Act
        final result = CorticalNeuronModel.fromJson(jsonMap);

        // Assert
        expect(result.id, equals('cortical-456'));
        expect(result.description, isNull);
        expect(result.metadata, isNull);
        expect(result.currentState, isNull);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // Act
        final result = tCorticalNeuronModel.toJson();

        // Assert
        final expectedMap = {
          'id': 'cortical-456',
          'name': 'Authentication Service',
          'type': 'cortical',
          'status': 'active',
          'activationThreshold': 0.85,
          'processedSignalCount': 5000,
          'averageProcessingTimeMs': 150,
          'lastActiveAt': '2025-11-07T12:00:00.000Z',
          'description': 'Stateful auth service with session management',
          'metadata': {
            'version': '2.1.0',
            'region': 'us-east-1',
          },
          'stateSize': 2048576,
          'stateChanges': 342,
          'uptimeMs': 7200000,
          'restartCount': 2,
          'currentState': {
            'activeSessions': 127,
            'cacheSize': 1024,
          },
        };

        expect(result, equals(expectedMap));
      });
    });

    group('toEntity', () {
      test('should convert model to CorticalNeuron entity', () {
        // Act
        final result = tCorticalNeuronModel.toEntity();

        // Assert
        expect(result, isA<CorticalNeuron>());
        expect(result.id, equals('cortical-456'));
        expect(result.name, equals('Authentication Service'));
        expect(result.type, equals('cortical'));
        expect(result.status, equals('active'));
        expect(result.activationThreshold, equals(0.85));
        expect(result.processedSignalCount, equals(5000));
        expect(
          result.averageProcessingTime,
          equals(const Duration(milliseconds: 150)),
        );
        expect(
          result.lastActiveAt,
          equals(DateTime.parse('2025-11-07T12:00:00Z')),
        );
        expect(
          result.description,
          equals('Stateful auth service with session management'),
        );
        expect(result.metadata, equals({
          'version': '2.1.0',
          'region': 'us-east-1',
        }));
        expect(result.stateSize, equals(2048576));
        expect(result.stateChanges, equals(342));
        expect(result.uptime, equals(const Duration(milliseconds: 7200000)));
        expect(result.restartCount, equals(2));
        expect(result.currentState, equals({
          'activeSessions': 127,
          'cacheSize': 1024,
        }));
      });

      test('should preserve entity computed properties', () {
        // Act
        final result = tCorticalNeuronModel.toEntity();

        // Assert
        // uptime is 7200000ms = 2 hours, stateChanges = 342
        // stateChangeRate = 342 / 2 = 171.0 changes per hour
        expect(result.stateChangeRate, equals(171.0));
        expect(result.isNewlyStarted, isFalse); // uptime is 2 hours
        expect(result.hasFrequentRestarts, isFalse); // restartCount is 2
      });
    });

    group('fromEntity', () {
      test('should create model from CorticalNeuron entity', () {
        // Arrange
        final entity = CorticalNeuron(
          id: 'cortical-789',
          name: 'Test Service',
          type: 'cortical',
          status: 'active',
          activationThreshold: 0.9,
          processedSignalCount: 100,
          averageProcessingTime: const Duration(milliseconds: 50),
          lastActiveAt: DateTime.parse('2025-11-07T10:00:00Z'),
          description: 'Test description',
          metadata: {'test': 'value'},
          stateSize: 1024,
          stateChanges: 10,
          uptime: const Duration(hours: 1),
          restartCount: 0,
          currentState: {'key': 'value'},
        );

        // Act
        final result = CorticalNeuronModel.fromEntity(entity);

        // Assert
        expect(result.id, equals('cortical-789'));
        expect(result.name, equals('Test Service'));
        expect(result.stateSize, equals(1024));
        expect(result.stateChanges, equals(10));
        expect(result.uptimeMs, equals(3600000)); // 1 hour in ms
        expect(result.restartCount, equals(0));
        expect(result.currentState, equals({'key': 'value'}));
      });
    });

    group('copyWith', () {
      test('should return a new model with updated values', () {
        // Act
        final result = tCorticalNeuronModel.copyWith(
          status: 'inactive',
          stateChanges: 500,
          restartCount: 3,
        );

        // Assert
        expect(result.id, equals(tCorticalNeuronModel.id));
        expect(result.status, equals('inactive'));
        expect(result.stateChanges, equals(500));
        expect(result.restartCount, equals(3));
        expect(result.name, equals(tCorticalNeuronModel.name));
        expect(result.stateSize, equals(tCorticalNeuronModel.stateSize));
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final model1 = CorticalNeuronModel(
          id: 'cortical-456',
          name: 'Authentication Service',
          type: 'cortical',
          status: 'active',
          activationThreshold: 0.85,
          processedSignalCount: 5000,
          averageProcessingTimeMs: 150,
          lastActiveAt: DateTime.parse('2025-11-07T12:00:00Z'),
          stateSize: 2048576,
          stateChanges: 342,
          uptimeMs: 7200000,
          restartCount: 2,
        );

        final model2 = CorticalNeuronModel(
          id: 'cortical-456',
          name: 'Authentication Service',
          type: 'cortical',
          status: 'active',
          activationThreshold: 0.85,
          processedSignalCount: 5000,
          averageProcessingTimeMs: 150,
          lastActiveAt: DateTime.parse('2025-11-07T12:00:00Z'),
          stateSize: 2048576,
          stateChanges: 342,
          uptimeMs: 7200000,
          restartCount: 2,
        );

        // Assert
        expect(model1, equals(model2));
        expect(model1.hashCode, equals(model2.hashCode));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        final model1 = tCorticalNeuronModel;
        final model2 = tCorticalNeuronModel.copyWith(restartCount: 10);

        // Assert
        expect(model1, isNot(equals(model2)));
      });
    });
  });
}
