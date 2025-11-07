import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/features/neurons/data/models/neural_node_model.dart';
import 'package:synapse_monitor/features/neurons/domain/entities/neural_node.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  group('NeuralNodeModel', () {
    final tNeuralNodeModel = NeuralNodeModel(
      id: 'neuron-123',
      name: 'User Service',
      type: 'cortical',
      status: 'active',
      activationThreshold: 0.75,
      processedSignalCount: 1250,
      averageProcessingTimeMs: 125,
      lastActiveAt: DateTime.parse('2025-11-07T12:00:00Z'),
      description: 'Handles user authentication',
      metadata: {'version': '1.0.0'},
    );

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Arrange
        final jsonMap = json.decode(fixture('neural_node.json'))
            as Map<String, dynamic>;

        // Act
        final result = NeuralNodeModel.fromJson(jsonMap);

        // Assert
        expect(result, equals(tNeuralNodeModel));
      });

      test('should handle missing optional fields', () {
        // Arrange
        final jsonMap = {
          'id': 'neuron-123',
          'name': 'User Service',
          'type': 'cortical',
          'status': 'active',
          'activationThreshold': 0.75,
          'processedSignalCount': 1250,
          'averageProcessingTimeMs': 125,
          'lastActiveAt': '2025-11-07T12:00:00Z',
        };

        // Act
        final result = NeuralNodeModel.fromJson(jsonMap);

        // Assert
        expect(result.id, equals('neuron-123'));
        expect(result.description, isNull);
        expect(result.metadata, isNull);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // Act
        final result = tNeuralNodeModel.toJson();

        // Assert
        final expectedMap = {
          'id': 'neuron-123',
          'name': 'User Service',
          'type': 'cortical',
          'status': 'active',
          'activationThreshold': 0.75,
          'processedSignalCount': 1250,
          'averageProcessingTimeMs': 125,
          'lastActiveAt': '2025-11-07T12:00:00.000Z',
          'description': 'Handles user authentication',
          'metadata': {'version': '1.0.0'},
        };

        expect(result, equals(expectedMap));
      });
    });

    group('toEntity', () {
      test('should convert model to NeuralNode entity', () {
        // Act
        final result = tNeuralNodeModel.toEntity();

        // Assert
        expect(result, isA<NeuralNode>());
        expect(result.id, equals('neuron-123'));
        expect(result.name, equals('User Service'));
        expect(result.type, equals('cortical'));
        expect(result.status, equals('active'));
        expect(result.activationThreshold, equals(0.75));
        expect(result.processedSignalCount, equals(1250));
        expect(
          result.averageProcessingTime,
          equals(const Duration(milliseconds: 125)),
        );
        expect(result.lastActiveAt, equals(DateTime.parse('2025-11-07T12:00:00Z')));
        expect(result.description, equals('Handles user authentication'));
        expect(result.metadata, equals({'version': '1.0.0'}));
      });
    });

    group('copyWith', () {
      test('should return a new model with updated values', () {
        // Act
        final result = tNeuralNodeModel.copyWith(
          status: 'inactive',
          processedSignalCount: 2000,
        );

        // Assert
        expect(result.id, equals(tNeuralNodeModel.id));
        expect(result.status, equals('inactive'));
        expect(result.processedSignalCount, equals(2000));
        expect(result.name, equals(tNeuralNodeModel.name));
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final model1 = NeuralNodeModel(
          id: 'neuron-123',
          name: 'User Service',
          type: 'cortical',
          status: 'active',
          activationThreshold: 0.75,
          processedSignalCount: 1250,
          averageProcessingTimeMs: 125,
          lastActiveAt: DateTime.parse('2025-11-07T12:00:00Z'),
        );

        final model2 = NeuralNodeModel(
          id: 'neuron-123',
          name: 'User Service',
          type: 'cortical',
          status: 'active',
          activationThreshold: 0.75,
          processedSignalCount: 1250,
          averageProcessingTimeMs: 125,
          lastActiveAt: DateTime.parse('2025-11-07T12:00:00Z'),
        );

        // Assert
        expect(model1, equals(model2));
        expect(model1.hashCode, equals(model2.hashCode));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        final model1 = tNeuralNodeModel;
        final model2 = tNeuralNodeModel.copyWith(status: 'inactive');

        // Assert
        expect(model1, isNot(equals(model2)));
      });
    });
  });
}
