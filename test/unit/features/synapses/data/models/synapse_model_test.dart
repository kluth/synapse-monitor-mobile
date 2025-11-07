import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/features/synapses/data/models/synapse_model.dart';
import 'package:synapse_monitor/features/synapses/domain/entities/synapse.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  group('SynapseModel', () {
    final tSynapseModel = SynapseModel(
      id: 'synapse-001',
      sourceNeuronId: 'neuron-123',
      targetNeuronId: 'neuron-456',
      weight: 0.85,
      signalType: 'excitatory',
      isMyelinated: true,
      usageCount: 5000,
      lastStrengthenedAt: DateTime.parse('2025-11-07T10:00:00Z'),
      isPruningCandidate: false,
      createdAt: DateTime.parse('2025-11-01T08:00:00Z'),
      transmissionSpeedMs: 15,
    );

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Arrange
        final jsonMap =
            json.decode(fixture('synapse.json')) as Map<String, dynamic>;

        // Act
        final result = SynapseModel.fromJson(jsonMap);

        // Assert
        expect(result, equals(tSynapseModel));
      });

      test('should handle missing optional fields', () {
        // Arrange
        final jsonMap = {
          'id': 'synapse-001',
          'sourceNeuronId': 'neuron-123',
          'targetNeuronId': 'neuron-456',
          'weight': 0.85,
          'signalType': 'excitatory',
          'isMyelinated': true,
          'usageCount': 5000,
          'lastStrengthenedAt': '2025-11-07T10:00:00Z',
          'isPruningCandidate': false,
        };

        // Act
        final result = SynapseModel.fromJson(jsonMap);

        // Assert
        expect(result.id, equals('synapse-001'));
        expect(result.createdAt, isNull);
        expect(result.transmissionSpeedMs, isNull);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // Act
        final result = tSynapseModel.toJson();

        // Assert
        final expectedMap = {
          'id': 'synapse-001',
          'sourceNeuronId': 'neuron-123',
          'targetNeuronId': 'neuron-456',
          'weight': 0.85,
          'signalType': 'excitatory',
          'isMyelinated': true,
          'usageCount': 5000,
          'lastStrengthenedAt': '2025-11-07T10:00:00.000Z',
          'isPruningCandidate': false,
          'createdAt': '2025-11-01T08:00:00.000Z',
          'transmissionSpeedMs': 15,
        };

        expect(result, equals(expectedMap));
      });

      test('should handle null optional fields in JSON output', () {
        // Arrange
        final model = SynapseModel(
          id: 'synapse-002',
          sourceNeuronId: 'neuron-123',
          targetNeuronId: 'neuron-456',
          weight: 0.5,
          signalType: 'inhibitory',
          isMyelinated: false,
          usageCount: 100,
          lastStrengthenedAt: DateTime.parse('2025-11-07T10:00:00Z'),
          isPruningCandidate: true,
          createdAt: null,
          transmissionSpeedMs: null,
        );

        // Act
        final result = model.toJson();

        // Assert
        expect(result['createdAt'], isNull);
        expect(result['transmissionSpeedMs'], isNull);
      });
    });

    group('toEntity', () {
      test('should convert model to Synapse entity', () {
        // Act
        final result = tSynapseModel.toEntity();

        // Assert
        expect(result, isA<Synapse>());
        expect(result.id, equals('synapse-001'));
        expect(result.sourceNeuronId, equals('neuron-123'));
        expect(result.targetNeuronId, equals('neuron-456'));
        expect(result.weight, equals(0.85));
        expect(result.signalType, equals('excitatory'));
        expect(result.isMyelinated, isTrue);
        expect(result.usageCount, equals(5000));
        expect(
          result.lastStrengthenedAt,
          equals(DateTime.parse('2025-11-07T10:00:00Z')),
        );
        expect(result.isPruningCandidate, isFalse);
        expect(result.createdAt, equals(DateTime.parse('2025-11-01T08:00:00Z')));
        expect(
          result.transmissionSpeed,
          equals(const Duration(milliseconds: 15)),
        );
      });

      test('should preserve entity computed properties', () {
        // Act
        final result = tSynapseModel.toEntity();

        // Assert
        expect(result.isExcitatory, isTrue);
        expect(result.isInhibitory, isFalse);
        expect(result.isStrong, isTrue); // weight 0.85 > 0.7
        expect(result.isWeak, isFalse);
        expect(result.isFrequentlyUsed, isTrue); // usageCount 5000 > 1000
        expect(result.strengthCategory, equals('Very Strong')); // weight >= 0.8
      });

      test('should handle null optional fields in entity conversion', () {
        // Arrange
        final model = SynapseModel(
          id: 'synapse-002',
          sourceNeuronId: 'neuron-123',
          targetNeuronId: 'neuron-456',
          weight: 0.5,
          signalType: 'inhibitory',
          isMyelinated: false,
          usageCount: 100,
          lastStrengthenedAt: DateTime.parse('2025-11-07T10:00:00Z'),
          isPruningCandidate: true,
          createdAt: null,
          transmissionSpeedMs: null,
        );

        // Act
        final result = model.toEntity();

        // Assert
        expect(result.createdAt, isNull);
        expect(result.transmissionSpeed, isNull);
      });
    });

    group('fromEntity', () {
      test('should create model from Synapse entity', () {
        // Arrange
        final entity = Synapse(
          id: 'synapse-003',
          sourceNeuronId: 'neuron-789',
          targetNeuronId: 'neuron-012',
          weight: 0.65,
          signalType: 'inhibitory',
          isMyelinated: true,
          usageCount: 2500,
          lastStrengthenedAt: DateTime.parse('2025-11-06T15:00:00Z'),
          isPruningCandidate: false,
          createdAt: DateTime.parse('2025-10-15T09:00:00Z'),
          transmissionSpeed: const Duration(milliseconds: 25),
        );

        // Act
        final result = SynapseModel.fromEntity(entity);

        // Assert
        expect(result.id, equals('synapse-003'));
        expect(result.sourceNeuronId, equals('neuron-789'));
        expect(result.targetNeuronId, equals('neuron-012'));
        expect(result.weight, equals(0.65));
        expect(result.signalType, equals('inhibitory'));
        expect(result.isMyelinated, isTrue);
        expect(result.usageCount, equals(2500));
        expect(
          result.lastStrengthenedAt,
          equals(DateTime.parse('2025-11-06T15:00:00Z')),
        );
        expect(result.isPruningCandidate, isFalse);
        expect(result.createdAt, equals(DateTime.parse('2025-10-15T09:00:00Z')));
        expect(result.transmissionSpeedMs, equals(25));
      });
    });

    group('copyWith', () {
      test('should return a new model with updated values', () {
        // Act
        final result = tSynapseModel.copyWith(
          weight: 0.95,
          usageCount: 10000,
          isPruningCandidate: true,
        );

        // Assert
        expect(result.id, equals(tSynapseModel.id));
        expect(result.weight, equals(0.95));
        expect(result.usageCount, equals(10000));
        expect(result.isPruningCandidate, isTrue);
        expect(result.sourceNeuronId, equals(tSynapseModel.sourceNeuronId));
        expect(result.signalType, equals(tSynapseModel.signalType));
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final model1 = SynapseModel(
          id: 'synapse-001',
          sourceNeuronId: 'neuron-123',
          targetNeuronId: 'neuron-456',
          weight: 0.85,
          signalType: 'excitatory',
          isMyelinated: true,
          usageCount: 5000,
          lastStrengthenedAt: DateTime.parse('2025-11-07T10:00:00Z'),
          isPruningCandidate: false,
        );

        final model2 = SynapseModel(
          id: 'synapse-001',
          sourceNeuronId: 'neuron-123',
          targetNeuronId: 'neuron-456',
          weight: 0.85,
          signalType: 'excitatory',
          isMyelinated: true,
          usageCount: 5000,
          lastStrengthenedAt: DateTime.parse('2025-11-07T10:00:00Z'),
          isPruningCandidate: false,
        );

        // Assert
        expect(model1, equals(model2));
        expect(model1.hashCode, equals(model2.hashCode));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        final model1 = tSynapseModel;
        final model2 = tSynapseModel.copyWith(weight: 0.5);

        // Assert
        expect(model1, isNot(equals(model2)));
      });
    });
  });
}
