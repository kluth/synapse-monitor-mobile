import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:synapse_monitor/core/error/failures.dart';
import 'package:synapse_monitor/domain/entities/neural_node.dart';
import 'package:synapse_monitor/domain/repositories/neuron_repository.dart';
import 'package:synapse_monitor/domain/usecases/get_neural_nodes.dart';

class MockNeuronRepository extends Mock implements NeuronRepository {}

/// 🔴 RED PHASE - GetNeuralNodes Use Case Tests
///
/// This test will FAIL until the GetNeuralNodes use case is implemented

void main() {
  late GetNeuralNodes usecase;
  late MockNeuronRepository mockRepository;

  setUp(() {
    mockRepository = MockNeuronRepository();
    usecase = GetNeuralNodes(mockRepository);
  });

  final tNeuralNodes = [
    NeuralNode(
      id: 'neuron-1',
      name: 'Node 1',
      type: NeuronType.cortical,
      activationThreshold: 0.7,
      currentActivation: 0.8,
      connectionCount: 10,
    ),
    NeuralNode(
      id: 'neuron-2',
      name: 'Node 2',
      type: NeuronType.reflex,
      activationThreshold: 0.6,
      currentActivation: 0.5,
      connectionCount: 5,
    ),
  ];

  group('GetNeuralNodes', () {
    test('should get list of neural nodes from repository', () async {
      // This test will FAIL - use case doesn't exist yet

      // Arrange
      when(() => mockRepository.getNeuralNodes())
          .thenAnswer((_) async => Right(tNeuralNodes));

      // Act
      final result = await usecase();

      // Assert
      expect(result, Right(tNeuralNodes));
      verify(() => mockRepository.getNeuralNodes()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return NetworkFailure when repository call fails', () async {
      // This test will FAIL

      // Arrange
      when(() => mockRepository.getNeuralNodes())
          .thenAnswer((_) async => Left(NetworkFailure()));

      // Act
      final result = await usecase();

      // Assert
      expect(result, Left(NetworkFailure()));
      verify(() => mockRepository.getNeuralNodes()).called(1);
    });

    test('should return ServerFailure when server error occurs', () async {
      // This test will FAIL

      // Arrange
      when(() => mockRepository.getNeuralNodes())
          .thenAnswer((_) async => Left(ServerFailure(statusCode: 500)));

      // Act
      final result = await usecase();

      // Assert
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Should return Left'),
      );
    });
  });
}
