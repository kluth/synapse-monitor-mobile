import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/features/synapses/data/models/network_graph_model.dart';
import 'package:synapse_monitor/features/synapses/data/models/synapse_model.dart';
import 'package:synapse_monitor/features/synapses/domain/entities/network_graph.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  group('NetworkGraphModel', () {
    final tSynapses = [
      SynapseModel(
        id: 'synapse-001',
        sourceNeuronId: 'neuron-123',
        targetNeuronId: 'neuron-456',
        weight: 0.85,
        signalType: 'excitatory',
        isMyelinated: true,
        usageCount: 5000,
        lastStrengthenedAt: DateTime.parse('2025-11-07T10:00:00Z'),
        isPruningCandidate: false,
      ),
      SynapseModel(
        id: 'synapse-002',
        sourceNeuronId: 'neuron-456',
        targetNeuronId: 'neuron-789',
        weight: 0.65,
        signalType: 'inhibitory',
        isMyelinated: false,
        usageCount: 2500,
        lastStrengthenedAt: DateTime.parse('2025-11-06T15:00:00Z'),
        isPruningCandidate: true,
      ),
    ];

    final tNetworkGraphModel = NetworkGraphModel(
      neuronIds: const ['neuron-123', 'neuron-456', 'neuron-789'],
      synapses: tSynapses,
      depth: 3,
      density: 4.5,
      totalNeurons: 3,
      totalConnections: 2,
      hasCycles: false,
      timestamp: DateTime.parse('2025-11-07T12:00:00Z'),
    );

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Arrange
        final jsonMap = json.decode(fixture('network_graph.json'))
            as Map<String, dynamic>;

        // Act
        final result = NetworkGraphModel.fromJson(jsonMap);

        // Assert
        expect(result, equals(tNetworkGraphModel));
      });

      test('should handle missing optional fields', () {
        // Arrange
        final jsonMap = {
          'neuronIds': ['neuron-123'],
          'synapses': [],
          'depth': 1,
          'density': 0.0,
          'totalNeurons': 1,
          'totalConnections': 0,
        };

        // Act
        final result = NetworkGraphModel.fromJson(jsonMap);

        // Assert
        expect(result.neuronIds, equals(['neuron-123']));
        expect(result.hasCycles, isFalse); // default value
        expect(result.timestamp, isNull);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // Act
        final result = tNetworkGraphModel.toJson();

        // Assert
        expect(result['neuronIds'], equals(['neuron-123', 'neuron-456', 'neuron-789']));
        expect(result['depth'], equals(3));
        expect(result['density'], equals(4.5));
        expect(result['totalNeurons'], equals(3));
        expect(result['totalConnections'], equals(2));
        expect(result['hasCycles'], isFalse);
        expect(result['timestamp'], equals('2025-11-07T12:00:00.000Z'));
        expect(result['synapses'], isList);
        expect(result['synapses'].length, equals(2));
      });

      test('should properly serialize nested synapse models', () {
        // Act
        final result = tNetworkGraphModel.toJson();

        // Assert
        final synapses = result['synapses'] as List;
        expect(synapses[0]['id'], equals('synapse-001'));
        expect(synapses[0]['weight'], equals(0.85));
        expect(synapses[1]['id'], equals('synapse-002'));
        expect(synapses[1]['weight'], equals(0.65));
      });
    });

    group('toEntity', () {
      test('should convert model to NetworkGraph entity', () {
        // Act
        final result = tNetworkGraphModel.toEntity();

        // Assert
        expect(result, isA<NetworkGraph>());
        expect(result.neuronIds, equals(['neuron-123', 'neuron-456', 'neuron-789']));
        expect(result.depth, equals(3));
        expect(result.density, equals(4.5));
        expect(result.totalNeurons, equals(3));
        expect(result.totalConnections, equals(2));
        expect(result.hasCycles, isFalse);
        expect(result.timestamp, equals(DateTime.parse('2025-11-07T12:00:00Z')));
        expect(result.synapses.length, equals(2));
      });

      test('should properly convert nested synapse models to entities', () {
        // Act
        final result = tNetworkGraphModel.toEntity();

        // Assert
        expect(result.synapses[0].id, equals('synapse-001'));
        expect(result.synapses[0].weight, equals(0.85));
        expect(result.synapses[0].isExcitatory, isTrue);
        expect(result.synapses[1].id, equals('synapse-002'));
        expect(result.synapses[1].weight, equals(0.65));
        expect(result.synapses[1].isInhibitory, isTrue);
      });

      test('should preserve entity computed properties', () {
        // Act
        final result = tNetworkGraphModel.toEntity();

        // Assert
        expect(result.isSparse, isFalse); // density 4.5 >= 2.0
        expect(result.isDense, isFalse); // density 4.5 <= 5.0
        expect(result.isLarge, isFalse); // totalNeurons 3 <= 100
        expect(result.isComplex, isFalse); // depth 3 <= 5
        // connectivityPercentage = (2 / (3 * 2)) * 100 = 33.33%
        expect(result.connectivityPercentage, closeTo(33.33, 0.01));
        expect(result.myelinatedCount, equals(1));
        expect(result.excitatoryCount, equals(1));
        expect(result.inhibitoryCount, equals(1));
        expect(result.pruningCandidatesCount, equals(1));
        // averageWeight = (0.85 + 0.65) / 2 = 0.75
        expect(result.averageWeight, equals(0.75));
      });
    });

    group('fromEntity', () {
      test('should create model from NetworkGraph entity', () {
        // Arrange
        final entity = NetworkGraph(
          neuronIds: const ['neuron-001', 'neuron-002'],
          synapses: [
            tSynapses[0].toEntity(),
          ],
          depth: 2,
          density: 3.0,
          totalNeurons: 2,
          totalConnections: 1,
          hasCycles: true,
          timestamp: DateTime.parse('2025-11-05T10:00:00Z'),
        );

        // Act
        final result = NetworkGraphModel.fromEntity(entity);

        // Assert
        expect(result.neuronIds, equals(['neuron-001', 'neuron-002']));
        expect(result.depth, equals(2));
        expect(result.density, equals(3.0));
        expect(result.totalNeurons, equals(2));
        expect(result.totalConnections, equals(1));
        expect(result.hasCycles, isTrue);
        expect(result.timestamp, equals(DateTime.parse('2025-11-05T10:00:00Z')));
        expect(result.synapses.length, equals(1));
      });
    });

    group('copyWith', () {
      test('should return a new model with updated values', () {
        // Act
        final result = tNetworkGraphModel.copyWith(
          depth: 5,
          density: 6.5,
          hasCycles: true,
        );

        // Assert
        expect(result.neuronIds, equals(tNetworkGraphModel.neuronIds));
        expect(result.depth, equals(5));
        expect(result.density, equals(6.5));
        expect(result.hasCycles, isTrue);
        expect(result.totalNeurons, equals(tNetworkGraphModel.totalNeurons));
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final model1 = NetworkGraphModel(
          neuronIds: const ['neuron-123'],
          synapses: const [],
          depth: 1,
          density: 0.0,
          totalNeurons: 1,
          totalConnections: 0,
          hasCycles: false,
        );

        final model2 = NetworkGraphModel(
          neuronIds: const ['neuron-123'],
          synapses: const [],
          depth: 1,
          density: 0.0,
          totalNeurons: 1,
          totalConnections: 0,
          hasCycles: false,
        );

        // Assert
        expect(model1, equals(model2));
        expect(model1.hashCode, equals(model2.hashCode));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        final model1 = tNetworkGraphModel;
        final model2 = tNetworkGraphModel.copyWith(depth: 10);

        // Assert
        expect(model1, isNot(equals(model2)));
      });
    });
  });
}
