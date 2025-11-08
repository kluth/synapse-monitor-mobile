import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:synapse_monitor_mobile/core/network/http_client.dart';
import 'package:synapse_monitor_mobile/data/datasources/remote/synapse_remote_data_source.dart';
import 'package:synapse_monitor_mobile/data/models/synapse_model.dart';
import 'package:synapse_monitor_mobile/data/models/network_graph_model.dart';
import 'package:synapse_monitor_mobile/core/error/exceptions.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late SynapseRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SynapseRemoteDataSourceImpl(httpClient: mockHttpClient);
  });

  group('🔴 RED - getAllSynapses', () {
    test('should return list of SynapseModel when API call is successful', () async {
      // This test will FAIL - implementation doesn't exist yet

      // Arrange
      final tResponse = {
        'data': [
          {
            'id': 'synapse-123',
            'sourceNeuronId': 'neuron-001',
            'targetNeuronId': 'neuron-002',
            'weight': 0.75,
            'signalType': 'excitatory',
            'transmissionSpeed': 100.0,
            'lastTransmission': '2024-01-01T00:00:00Z',
          }
        ]
      };

      when(() => mockHttpClient.get('/api/synapses'))
          .thenAnswer((_) async => Response(
                data: tResponse,
                statusCode: 200,
                requestOptions: RequestOptions(path: '/api/synapses'),
              ));

      // Act
      final result = await dataSource.getAllSynapses();

      // Assert
      expect(result, isA<List<SynapseModel>>());
      expect(result.length, 1);
      expect(result.first.id, 'synapse-123');
      expect(result.first.weight, 0.75);
      verify(() => mockHttpClient.get('/api/synapses')).called(1);
    });

    test('should throw ServerException when API call fails', () async {
      // This test will FAIL - exception handling doesn't exist yet

      // Arrange
      when(() => mockHttpClient.get('/api/synapses'))
          .thenThrow(DioException(
            requestOptions: RequestOptions(path: '/api/synapses'),
            response: Response(
              statusCode: 500,
              requestOptions: RequestOptions(path: '/api/synapses'),
            ),
          ));

      // Act
      final call = dataSource.getAllSynapses;

      // Assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });

  group('🔴 RED - getSynapseById', () {
    const tSynapseId = 'synapse-123';

    test('should return SynapseModel when API call is successful', () async {
      // This test will FAIL - implementation doesn't exist yet

      // Arrange
      final tResponse = {
        'data': {
          'id': tSynapseId,
          'sourceNeuronId': 'neuron-001',
          'targetNeuronId': 'neuron-002',
          'weight': 0.75,
          'signalType': 'excitatory',
          'transmissionSpeed': 100.0,
          'lastTransmission': '2024-01-01T00:00:00Z',
        }
      };

      when(() => mockHttpClient.get('/api/synapses/$tSynapseId'))
          .thenAnswer((_) async => Response(
                data: tResponse,
                statusCode: 200,
                requestOptions: RequestOptions(path: '/api/synapses/$tSynapseId'),
              ));

      // Act
      final result = await dataSource.getSynapseById(tSynapseId);

      // Assert
      expect(result, isA<SynapseModel>());
      expect(result.id, tSynapseId);
      verify(() => mockHttpClient.get('/api/synapses/$tSynapseId')).called(1);
    });

    test('should throw NotFoundException when synapse does not exist', () async {
      // This test will FAIL - exception handling doesn't exist yet

      // Arrange
      when(() => mockHttpClient.get('/api/synapses/$tSynapseId'))
          .thenThrow(DioException(
            requestOptions: RequestOptions(path: '/api/synapses/$tSynapseId'),
            response: Response(
              statusCode: 404,
              requestOptions: RequestOptions(path: '/api/synapses/$tSynapseId'),
            ),
          ));

      // Act
      final call = () => dataSource.getSynapseById(tSynapseId);

      // Assert
      expect(call, throwsA(isA<NotFoundException>()));
    });
  });

  group('🔴 RED - getNetworkGraph', () {
    test('should return NetworkGraphModel with nodes and edges', () async {
      // This test will FAIL - implementation doesn't exist yet

      // Arrange
      final tResponse = {
        'data': {
          'nodes': [
            {
              'id': 'neuron-001',
              'type': 'cortical',
              'position': {'x': 100.0, 'y': 200.0},
              'status': 'active',
            }
          ],
          'edges': [
            {
              'id': 'synapse-123',
              'source': 'neuron-001',
              'target': 'neuron-002',
              'weight': 0.75,
              'type': 'excitatory',
            }
          ],
          'metadata': {
            'totalNodes': 2,
            'totalEdges': 1,
            'averageConnectivity': 1.0,
          }
        }
      };

      when(() => mockHttpClient.get('/api/network/graph'))
          .thenAnswer((_) async => Response(
                data: tResponse,
                statusCode: 200,
                requestOptions: RequestOptions(path: '/api/network/graph'),
              ));

      // Act
      final result = await dataSource.getNetworkGraph();

      // Assert
      expect(result, isA<NetworkGraphModel>());
      expect(result.nodes.length, 1);
      expect(result.edges.length, 1);
      verify(() => mockHttpClient.get('/api/network/graph')).called(1);
    });

    test('should throw ServerException when graph data is malformed', () async {
      // This test will FAIL - exception handling doesn't exist yet

      // Arrange
      when(() => mockHttpClient.get('/api/network/graph'))
          .thenAnswer((_) async => Response(
                data: {'invalid': 'data'},
                statusCode: 200,
                requestOptions: RequestOptions(path: '/api/network/graph'),
              ));

      // Act
      final call = dataSource.getNetworkGraph;

      // Assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });

  group('🔴 RED - updateSynapseWeight', () {
    const tSynapseId = 'synapse-123';
    const tNewWeight = 0.85;

    test('should return updated SynapseModel when weight update is successful', () async {
      // This test will FAIL - implementation doesn't exist yet

      // Arrange
      final tResponse = {
        'data': {
          'id': tSynapseId,
          'sourceNeuronId': 'neuron-001',
          'targetNeuronId': 'neuron-002',
          'weight': tNewWeight,
          'signalType': 'excitatory',
          'transmissionSpeed': 100.0,
          'lastTransmission': '2024-01-01T00:01:00Z',
        }
      };

      when(() => mockHttpClient.patch(
            '/api/synapses/$tSynapseId/weight',
            data: {'weight': tNewWeight},
          )).thenAnswer((_) async => Response(
            data: tResponse,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/api/synapses/$tSynapseId/weight'),
          ));

      // Act
      final result = await dataSource.updateSynapseWeight(tSynapseId, tNewWeight);

      // Assert
      expect(result, isA<SynapseModel>());
      expect(result.weight, tNewWeight);
      verify(() => mockHttpClient.patch(
            '/api/synapses/$tSynapseId/weight',
            data: {'weight': tNewWeight},
          )).called(1);
    });

    test('should throw ValidationException when weight is invalid', () async {
      // This test will FAIL - exception handling doesn't exist yet

      // Arrange
      const tInvalidWeight = 1.5; // Weight should be between 0 and 1

      when(() => mockHttpClient.patch(
            '/api/synapses/$tSynapseId/weight',
            data: {'weight': tInvalidWeight},
          )).thenThrow(DioException(
            requestOptions: RequestOptions(path: '/api/synapses/$tSynapseId/weight'),
            response: Response(
              statusCode: 400,
              data: {'error': 'Weight must be between 0 and 1'},
              requestOptions: RequestOptions(path: '/api/synapses/$tSynapseId/weight'),
            ),
          ));

      // Act
      final call = () => dataSource.updateSynapseWeight(tSynapseId, tInvalidWeight);

      // Assert
      expect(call, throwsA(isA<ValidationException>()));
    });
  });
}
