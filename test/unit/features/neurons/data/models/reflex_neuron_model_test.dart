import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/features/neurons/data/models/reflex_neuron_model.dart';
import 'package:synapse_monitor/features/neurons/domain/entities/reflex_neuron.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  group('ReflexNeuronModel', () {
    final tReflexNeuronModel = ReflexNeuronModel(
      id: 'reflex-789',
      name: 'Image Resize Function',
      type: 'reflex',
      status: 'active',
      activationThreshold: 0.5,
      processedSignalCount: 10000,
      averageProcessingTimeMs: 75,
      lastActiveAt: DateTime.parse('2025-11-07T12:00:00Z'),
      description: 'Serverless image processing function',
      metadata: {
        'runtime': 'node18',
        'memory': '512MB',
      },
      invocationCount: 10000,
      coldStartCount: 150,
      scaleToZeroEvents: 45,
      responseTimeMs: 250,
      lastInvocationAt: DateTime.parse('2025-11-07T11:58:00Z'),
    );

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Arrange
        final jsonMap = json.decode(fixture('reflex_neuron.json'))
            as Map<String, dynamic>;

        // Act
        final result = ReflexNeuronModel.fromJson(jsonMap);

        // Assert
        expect(result, equals(tReflexNeuronModel));
      });

      test('should handle missing optional fields', () {
        // Arrange
        final jsonMap = {
          'id': 'reflex-789',
          'name': 'Image Resize Function',
          'type': 'reflex',
          'status': 'active',
          'activationThreshold': 0.5,
          'processedSignalCount': 10000,
          'averageProcessingTimeMs': 75,
          'lastActiveAt': '2025-11-07T12:00:00Z',
          'invocationCount': 10000,
          'coldStartCount': 150,
          'scaleToZeroEvents': 45,
          'responseTimeMs': 250,
          'lastInvocationAt': '2025-11-07T11:58:00Z',
        };

        // Act
        final result = ReflexNeuronModel.fromJson(jsonMap);

        // Assert
        expect(result.id, equals('reflex-789'));
        expect(result.description, isNull);
        expect(result.metadata, isNull);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // Act
        final result = tReflexNeuronModel.toJson();

        // Assert
        final expectedMap = {
          'id': 'reflex-789',
          'name': 'Image Resize Function',
          'type': 'reflex',
          'status': 'active',
          'activationThreshold': 0.5,
          'processedSignalCount': 10000,
          'averageProcessingTimeMs': 75,
          'lastActiveAt': '2025-11-07T12:00:00.000Z',
          'description': 'Serverless image processing function',
          'metadata': {
            'runtime': 'node18',
            'memory': '512MB',
          },
          'invocationCount': 10000,
          'coldStartCount': 150,
          'scaleToZeroEvents': 45,
          'responseTimeMs': 250,
          'lastInvocationAt': '2025-11-07T11:58:00.000Z',
        };

        expect(result, equals(expectedMap));
      });
    });

    group('toEntity', () {
      test('should convert model to ReflexNeuron entity', () {
        // Act
        final result = tReflexNeuronModel.toEntity();

        // Assert
        expect(result, isA<ReflexNeuron>());
        expect(result.id, equals('reflex-789'));
        expect(result.name, equals('Image Resize Function'));
        expect(result.type, equals('reflex'));
        expect(result.status, equals('active'));
        expect(result.activationThreshold, equals(0.5));
        expect(result.processedSignalCount, equals(10000));
        expect(
          result.averageProcessingTime,
          equals(const Duration(milliseconds: 75)),
        );
        expect(
          result.lastActiveAt,
          equals(DateTime.parse('2025-11-07T12:00:00Z')),
        );
        expect(
          result.description,
          equals('Serverless image processing function'),
        );
        expect(result.metadata, equals({
          'runtime': 'node18',
          'memory': '512MB',
        }));
        expect(result.invocationCount, equals(10000));
        expect(result.coldStartCount, equals(150));
        expect(result.scaleToZeroEvents, equals(45));
        expect(result.responseTime, equals(const Duration(milliseconds: 250)));
        expect(
          result.lastInvocationAt,
          equals(DateTime.parse('2025-11-07T11:58:00Z')),
        );
      });

      test('should preserve entity computed properties', () {
        // Act
        final result = tReflexNeuronModel.toEntity();

        // Assert
        // coldStartRate = (150 / 10000) * 100 = 1.5%
        expect(result.coldStartRate, equals(1.5));
        expect(result.hasHighColdStartRate, isFalse); // 1.5% < 20%
        expect(result.hasAcceptableResponseTime, isTrue); // 250ms < 500ms
        // Note: isIdle depends on current time, so we won't test it here
      });
    });

    group('fromEntity', () {
      test('should create model from ReflexNeuron entity', () {
        // Arrange
        final entity = ReflexNeuron(
          id: 'reflex-999',
          name: 'Test Function',
          type: 'reflex',
          status: 'active',
          activationThreshold: 0.7,
          processedSignalCount: 500,
          averageProcessingTime: const Duration(milliseconds: 100),
          lastActiveAt: DateTime.parse('2025-11-07T10:00:00Z'),
          description: 'Test description',
          metadata: {'test': 'value'},
          invocationCount: 500,
          coldStartCount: 50,
          scaleToZeroEvents: 10,
          responseTime: const Duration(milliseconds: 300),
          lastInvocationAt: DateTime.parse('2025-11-07T09:55:00Z'),
        );

        // Act
        final result = ReflexNeuronModel.fromEntity(entity);

        // Assert
        expect(result.id, equals('reflex-999'));
        expect(result.name, equals('Test Function'));
        expect(result.invocationCount, equals(500));
        expect(result.coldStartCount, equals(50));
        expect(result.scaleToZeroEvents, equals(10));
        expect(result.responseTimeMs, equals(300));
        expect(
          result.lastInvocationAt,
          equals(DateTime.parse('2025-11-07T09:55:00Z')),
        );
      });
    });

    group('copyWith', () {
      test('should return a new model with updated values', () {
        // Act
        final result = tReflexNeuronModel.copyWith(
          status: 'inactive',
          invocationCount: 15000,
          coldStartCount: 200,
        );

        // Assert
        expect(result.id, equals(tReflexNeuronModel.id));
        expect(result.status, equals('inactive'));
        expect(result.invocationCount, equals(15000));
        expect(result.coldStartCount, equals(200));
        expect(result.name, equals(tReflexNeuronModel.name));
        expect(
          result.scaleToZeroEvents,
          equals(tReflexNeuronModel.scaleToZeroEvents),
        );
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final model1 = ReflexNeuronModel(
          id: 'reflex-789',
          name: 'Image Resize Function',
          type: 'reflex',
          status: 'active',
          activationThreshold: 0.5,
          processedSignalCount: 10000,
          averageProcessingTimeMs: 75,
          lastActiveAt: DateTime.parse('2025-11-07T12:00:00Z'),
          invocationCount: 10000,
          coldStartCount: 150,
          scaleToZeroEvents: 45,
          responseTimeMs: 250,
          lastInvocationAt: DateTime.parse('2025-11-07T11:58:00Z'),
        );

        final model2 = ReflexNeuronModel(
          id: 'reflex-789',
          name: 'Image Resize Function',
          type: 'reflex',
          status: 'active',
          activationThreshold: 0.5,
          processedSignalCount: 10000,
          averageProcessingTimeMs: 75,
          lastActiveAt: DateTime.parse('2025-11-07T12:00:00Z'),
          invocationCount: 10000,
          coldStartCount: 150,
          scaleToZeroEvents: 45,
          responseTimeMs: 250,
          lastInvocationAt: DateTime.parse('2025-11-07T11:58:00Z'),
        );

        // Assert
        expect(model1, equals(model2));
        expect(model1.hashCode, equals(model2.hashCode));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        final model1 = tReflexNeuronModel;
        final model2 = tReflexNeuronModel.copyWith(coldStartCount: 300);

        // Assert
        expect(model1, isNot(equals(model2)));
      });
    });
  });
}
