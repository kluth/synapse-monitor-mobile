import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:synapse_monitor/core/error/failures.dart';
import 'package:synapse_monitor/domain/entities/synapse.dart';
import 'package:synapse_monitor/domain/entities/network_graph.dart';
import 'package:synapse_monitor/domain/repositories/synapse_repository.dart';
import 'package:synapse_monitor/domain/usecases/get_all_synapses.dart';
import 'package:synapse_monitor/domain/usecases/get_synapse_by_id.dart';
import 'package:synapse_monitor/domain/usecases/get_network_graph.dart';
import 'package:synapse_monitor/domain/usecases/update_synapse_weight.dart';
import 'package:synapse_monitor/domain/usecases/get_synapses_by_neuron.dart';

class MockSynapseRepository extends Mock implements SynapseRepository {}

/// 🔴 RED PHASE - Synapse Use Cases Tests (5 use cases)

void main() {
  late MockSynapseRepository mockRepository;

  setUp(() {
    mockRepository = MockSynapseRepository();
  });

  final tSynapse = Synapse(
    id: 'synapse-123',
    sourceNeuronId: 'neuron-1',
    targetNeuronId: 'neuron-2',
    weight: 0.75,
  );

  final tSynapses = [tSynapse];

  group('GetAllSynapses', () {
    late GetAllSynapses usecase;

    setUp(() {
      usecase = GetAllSynapses(mockRepository);
    });

    test('should get all synapses from repository', () async {
      // This test will FAIL

      when(() => mockRepository.getAllSynapses())
          .thenAnswer((_) async => Right(tSynapses));

      final result = await usecase();

      expect(result, Right(tSynapses));
      verify(() => mockRepository.getAllSynapses()).called(1);
    });

    test('should return NetworkFailure when connection fails', () async {
      // This test will FAIL

      when(() => mockRepository.getAllSynapses())
          .thenAnswer((_) async => Left(NetworkFailure()));

      final result = await usecase();

      expect(result, Left(NetworkFailure()));
    });
  });

  group('GetSynapseById', () {
    late GetSynapseById usecase;

    setUp(() {
      usecase = GetSynapseById(mockRepository);
    });

    test('should get synapse by id from repository', () async {
      // This test will FAIL

      when(() => mockRepository.getSynapseById('synapse-123'))
          .thenAnswer((_) async => Right(tSynapse));

      final result = await usecase(const GetSynapseByIdParams(id: 'synapse-123'));

      expect(result, Right(tSynapse));
      verify(() => mockRepository.getSynapseById('synapse-123')).called(1);
    });

    test('should return NotFoundFailure when synapse does not exist', () async {
      // This test will FAIL

      when(() => mockRepository.getSynapseById('nonexistent'))
          .thenAnswer((_) async => Left(NotFoundFailure(resource: 'Synapse')));

      final result = await usecase(const GetSynapseByIdParams(id: 'nonexistent'));

      result.fold(
        (failure) => expect(failure, isA<NotFoundFailure>()),
        (_) => fail('Should return Left'),
      );
    });
  });

  group('GetNetworkGraph', () {
    late GetNetworkGraph usecase;

    setUp(() {
      usecase = GetNetworkGraph(mockRepository);
    });

    final tNetworkGraph = NetworkGraph(
      nodes: [],
      edges: tSynapses,
    );

    test('should get network graph from repository', () async {
      // This test will FAIL

      when(() => mockRepository.getNetworkGraph())
          .thenAnswer((_) async => Right(tNetworkGraph));

      final result = await usecase();

      expect(result, Right(tNetworkGraph));
      verify(() => mockRepository.getNetworkGraph()).called(1);
    });

    test('should return ServerFailure when server error occurs', () async {
      // This test will FAIL

      when(() => mockRepository.getNetworkGraph())
          .thenAnswer((_) async => Left(ServerFailure(statusCode: 500)));

      final result = await usecase();

      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Should return Left'),
      );
    });
  });

  group('UpdateSynapseWeight', () {
    late UpdateSynapseWeight usecase;

    setUp(() {
      usecase = UpdateSynapseWeight(mockRepository);
    });

    test('should update synapse weight via repository', () async {
      // This test will FAIL

      final updatedSynapse = tSynapse.copyWith(weight: 0.9);
      when(() => mockRepository.updateSynapseWeight('synapse-123', 0.9))
          .thenAnswer((_) async => Right(updatedSynapse));

      final result = await usecase(
        const UpdateSynapseWeightParams(id: 'synapse-123', newWeight: 0.9),
      );

      expect(result, Right(updatedSynapse));
      verify(() => mockRepository.updateSynapseWeight('synapse-123', 0.9)).called(1);
    });

    test('should return ValidationFailure when weight is invalid', () async {
      // This test will FAIL

      when(() => mockRepository.updateSynapseWeight('synapse-123', 1.5))
          .thenAnswer((_) async => Left(ValidationFailure(message: 'Weight must be between 0 and 1')));

      final result = await usecase(
        const UpdateSynapseWeightParams(id: 'synapse-123', newWeight: 1.5),
      );

      result.fold(
        (failure) => expect(failure, isA<ValidationFailure>()),
        (_) => fail('Should return Left'),
      );
    });
  });

  group('GetSynapsesByNeuron', () {
    late GetSynapsesByNeuron usecase;

    setUp(() {
      usecase = GetSynapsesByNeuron(mockRepository);
    });

    test('should get synapses connected to a neuron', () async {
      // This test will FAIL

      when(() => mockRepository.getSynapsesByNeuronId('neuron-1'))
          .thenAnswer((_) async => Right(tSynapses));

      final result = await usecase(
        const GetSynapsesByNeuronParams(neuronId: 'neuron-1'),
      );

      expect(result, Right(tSynapses));
      verify(() => mockRepository.getSynapsesByNeuronId('neuron-1')).called(1);
    });

    test('should return empty list when neuron has no synapses', () async {
      // This test will FAIL

      when(() => mockRepository.getSynapsesByNeuronId('neuron-isolated'))
          .thenAnswer((_) async => const Right([]));

      final result = await usecase(
        const GetSynapsesByNeuronParams(neuronId: 'neuron-isolated'),
      );

      result.fold(
        (_) => fail('Should return Right'),
        (synapses) => expect(synapses, isEmpty),
      );
    });
  });
}
