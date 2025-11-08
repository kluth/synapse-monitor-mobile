import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:synapse_monitor/core/error/failures.dart';
import 'package:synapse_monitor/domain/entities/neural_node.dart';
import 'package:synapse_monitor/domain/repositories/neuron_repository.dart';
import 'package:synapse_monitor/domain/usecases/get_neuron_by_id.dart';
import 'package:synapse_monitor/domain/usecases/get_cortical_neurons.dart';
import 'package:synapse_monitor/domain/usecases/get_reflex_neurons.dart';
import 'package:synapse_monitor/domain/usecases/activate_neuron.dart';
import 'package:synapse_monitor/domain/usecases/deactivate_neuron.dart';

class MockNeuronRepository extends Mock implements NeuronRepository {}

/// 🔴 RED PHASE - Neuron Use Cases Tests (5 additional use cases)

void main() {
  late MockNeuronRepository mockRepository;

  setUp(() {
    mockRepository = MockNeuronRepository();
  });

  final tNeuron = NeuralNode(
    id: 'neuron-123',
    name: 'Test Neuron',
    type: NeuronType.cortical,
    activationThreshold: 0.7,
    currentActivation: 0.8,
    connectionCount: 10,
  );

  group('GetNeuronById', () {
    late GetNeuronById usecase;

    setUp(() {
      usecase = GetNeuronById(mockRepository);
    });

    test('should get neuron by id from repository', () async {
      // This test will FAIL

      when(() => mockRepository.getNeuronById('neuron-123'))
          .thenAnswer((_) async => Right(tNeuron));

      final result = await usecase(const GetNeuronByIdParams(id: 'neuron-123'));

      expect(result, Right(tNeuron));
      verify(() => mockRepository.getNeuronById('neuron-123')).called(1);
    });

    test('should return NotFoundFailure when neuron does not exist', () async {
      // This test will FAIL

      when(() => mockRepository.getNeuronById('nonexistent'))
          .thenAnswer((_) async => Left(NotFoundFailure(resource: 'Neuron')));

      final result = await usecase(const GetNeuronByIdParams(id: 'nonexistent'));

      result.fold(
        (failure) => expect(failure, isA<NotFoundFailure>()),
        (_) => fail('Should return Left'),
      );
    });
  });

  group('GetCorticalNeurons', () {
    late GetCorticalNeurons usecase;

    setUp(() {
      usecase = GetCorticalNeurons(mockRepository);
    });

    final tCorticalNeurons = [
      NeuralNode(
        id: 'neuron-1',
        name: 'Cortical 1',
        type: NeuronType.cortical,
        activationThreshold: 0.7,
        currentActivation: 0.8,
        connectionCount: 10,
      ),
    ];

    test('should get cortical neurons from repository', () async {
      // This test will FAIL

      when(() => mockRepository.getCorticalNeurons())
          .thenAnswer((_) async => Right(tCorticalNeurons));

      final result = await usecase();

      expect(result, Right(tCorticalNeurons));
      verify(() => mockRepository.getCorticalNeurons()).called(1);
    });

    test('should return empty list when no cortical neurons exist', () async {
      // This test will FAIL

      when(() => mockRepository.getCorticalNeurons())
          .thenAnswer((_) async => const Right([]));

      final result = await usecase();

      result.fold(
        (_) => fail('Should return Right'),
        (neurons) => expect(neurons, isEmpty),
      );
    });
  });

  group('GetReflexNeurons', () {
    late GetReflexNeurons usecase;

    setUp(() {
      usecase = GetReflexNeurons(mockRepository);
    });

    final tReflexNeurons = [
      NeuralNode(
        id: 'neuron-2',
        name: 'Reflex 1',
        type: NeuronType.reflex,
        activationThreshold: 0.5,
        currentActivation: 0.6,
        connectionCount: 8,
      ),
    ];

    test('should get reflex neurons from repository', () async {
      // This test will FAIL

      when(() => mockRepository.getReflexNeurons())
          .thenAnswer((_) async => Right(tReflexNeurons));

      final result = await usecase();

      expect(result, Right(tReflexNeurons));
      verify(() => mockRepository.getReflexNeurons()).called(1);
    });
  });

  group('ActivateNeuron', () {
    late ActivateNeuron usecase;

    setUp(() {
      usecase = ActivateNeuron(mockRepository);
    });

    test('should activate neuron via repository', () async {
      // This test will FAIL

      when(() => mockRepository.activateNeuron('neuron-123'))
          .thenAnswer((_) async => Right(tNeuron));

      final result = await usecase(const ActivateNeuronParams(id: 'neuron-123'));

      expect(result, Right(tNeuron));
      verify(() => mockRepository.activateNeuron('neuron-123')).called(1);
    });

    test('should return ValidationFailure when neuron cannot be activated', () async {
      // This test will FAIL

      when(() => mockRepository.activateNeuron('neuron-123'))
          .thenAnswer((_) async => Left(ValidationFailure(message: 'Cannot activate')));

      final result = await usecase(const ActivateNeuronParams(id: 'neuron-123'));

      result.fold(
        (failure) => expect(failure, isA<ValidationFailure>()),
        (_) => fail('Should return Left'),
      );
    });
  });

  group('DeactivateNeuron', () {
    late DeactivateNeuron usecase;

    setUp(() {
      usecase = DeactivateNeuron(mockRepository);
    });

    test('should deactivate neuron via repository', () async {
      // This test will FAIL

      when(() => mockRepository.deactivateNeuron('neuron-123'))
          .thenAnswer((_) async => Right(tNeuron));

      final result = await usecase(const DeactivateNeuronParams(id: 'neuron-123'));

      expect(result, Right(tNeuron));
      verify(() => mockRepository.deactivateNeuron('neuron-123')).called(1);
    });

    test('should return NotFoundFailure when neuron does not exist', () async {
      // This test will FAIL

      when(() => mockRepository.deactivateNeuron('nonexistent'))
          .thenAnswer((_) async => Left(NotFoundFailure(resource: 'Neuron')));

      final result = await usecase(const DeactivateNeuronParams(id: 'nonexistent'));

      result.fold(
        (failure) => expect(failure, isA<NotFoundFailure>()),
        (_) => fail('Should return Left'),
      );
    });
  });
}
