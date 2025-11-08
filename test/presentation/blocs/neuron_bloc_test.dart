import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:synapse_monitor/core/error/failures.dart';
import 'package:synapse_monitor/domain/entities/neural_node.dart';
import 'package:synapse_monitor/domain/usecases/get_neural_nodes.dart';
import 'package:synapse_monitor/domain/usecases/get_neuron_by_id.dart';
import 'package:synapse_monitor/domain/usecases/activate_neuron.dart';
import 'package:synapse_monitor/domain/usecases/deactivate_neuron.dart';
import 'package:synapse_monitor/presentation/blocs/neuron/neuron_bloc.dart';

class MockGetNeuralNodes extends Mock implements GetNeuralNodes {}
class MockGetNeuronById extends Mock implements GetNeuronById {}
class MockActivateNeuron extends Mock implements ActivateNeuron {}
class MockDeactivateNeuron extends Mock implements DeactivateNeuron {}

/// 🔴 RED PHASE - NeuronBloc Tests
///
/// These tests WILL FAIL until the NeuronBloc is implemented

void main() {
  late NeuronBloc bloc;
  late MockGetNeuralNodes mockGetNeuralNodes;
  late MockGetNeuronById mockGetNeuronById;
  late MockActivateNeuron mockActivateNeuron;
  late MockDeactivateNeuron mockDeactivateNeuron;

  setUp(() {
    mockGetNeuralNodes = MockGetNeuralNodes();
    mockGetNeuronById = MockGetNeuronById();
    mockActivateNeuron = MockActivateNeuron();
    mockDeactivateNeuron = MockDeactivateNeuron();

    bloc = NeuronBloc(
      getNeuralNodes: mockGetNeuralNodes,
      getNeuronById: mockGetNeuronById,
      activateNeuron: mockActivateNeuron,
      deactivateNeuron: mockDeactivateNeuron,
    );
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
  ];

  final tNeuron = tNeuralNodes.first;

  group('Initial State', () {
    test('should have NeuronInitial as initial state', () async {
      // This test will FAIL

      expect(bloc.state, NeuronInitial());
    });
  });

  group('LoadNeuralNodes Event', () {
    blocTest<NeuronBloc, NeuronState>(
      'should emit [Loading, Loaded] when data is fetched successfully',
      build: () {
        when(() => mockGetNeuralNodes())
            .thenAnswer((_) async => Right(tNeuralNodes));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadNeuralNodesEvent()),
      expect: () => [
        NeuronLoading(),
        NeuronLoaded(neurons: tNeuralNodes),
      ],
      verify: (_) {
        verify(() => mockGetNeuralNodes()).called(1);
      },
    );

    blocTest<NeuronBloc, NeuronState>(
      'should emit [Loading, Error] when fetching fails',
      build: () {
        when(() => mockGetNeuralNodes())
            .thenAnswer((_) async => Left(NetworkFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadNeuralNodesEvent()),
      expect: () => [
        NeuronLoading(),
        const NeuronError(message: 'Please check your internet connection and try again.'),
      ],
    );

    blocTest<NeuronBloc, NeuronState>(
      'should emit [Loading, Error] with server error message',
      build: () {
        when(() => mockGetNeuralNodes())
            .thenAnswer((_) async => Left(ServerFailure(statusCode: 500)));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadNeuralNodesEvent()),
      expect: () => [
        NeuronLoading(),
        isA<NeuronError>(),
      ],
    );
  });

  group('LoadNeuronById Event', () {
    blocTest<NeuronBloc, NeuronState>(
      'should emit [Loading, NeuronDetailLoaded] when neuron is found',
      build: () {
        when(() => mockGetNeuronById(any()))
            .thenAnswer((_) async => Right(tNeuron));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadNeuronByIdEvent(id: 'neuron-1')),
      expect: () => [
        NeuronLoading(),
        NeuronDetailLoaded(neuron: tNeuron),
      ],
      verify: (_) {
        verify(() => mockGetNeuronById(const GetNeuronByIdParams(id: 'neuron-1'))).called(1);
      },
    );

    blocTest<NeuronBloc, NeuronState>(
      'should emit [Loading, Error] when neuron is not found',
      build: () {
        when(() => mockGetNeuronById(any()))
            .thenAnswer((_) async => Left(NotFoundFailure(resource: 'Neuron')));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadNeuronByIdEvent(id: 'nonexistent')),
      expect: () => [
        NeuronLoading(),
        isA<NeuronError>(),
      ],
    );
  });

  group('ActivateNeuron Event', () {
    blocTest<NeuronBloc, NeuronState>(
      'should emit [ActionInProgress, NeuronActivated] when activation succeeds',
      build: () {
        when(() => mockActivateNeuron(any()))
            .thenAnswer((_) async => Right(tNeuron));
        return bloc;
      },
      act: (bloc) => bloc.add(const ActivateNeuronEvent(id: 'neuron-1')),
      expect: () => [
        NeuronActionInProgress(),
        NeuronActivated(neuron: tNeuron),
      ],
      verify: (_) {
        verify(() => mockActivateNeuron(const ActivateNeuronParams(id: 'neuron-1'))).called(1);
      },
    );

    blocTest<NeuronBloc, NeuronState>(
      'should emit [ActionInProgress, Error] when activation fails',
      build: () {
        when(() => mockActivateNeuron(any()))
            .thenAnswer((_) async => Left(ValidationFailure(message: 'Cannot activate')));
        return bloc;
      },
      act: (bloc) => bloc.add(const ActivateNeuronEvent(id: 'neuron-1')),
      expect: () => [
        NeuronActionInProgress(),
        isA<NeuronError>(),
      ],
    );
  });

  group('DeactivateNeuron Event', () {
    blocTest<NeuronBloc, NeuronState>(
      'should emit [ActionInProgress, NeuronDeactivated] when deactivation succeeds',
      build: () {
        when(() => mockDeactivateNeuron(any()))
            .thenAnswer((_) async => Right(tNeuron));
        return bloc;
      },
      act: (bloc) => bloc.add(const DeactivateNeuronEvent(id: 'neuron-1')),
      expect: () => [
        NeuronActionInProgress(),
        NeuronDeactivated(neuron: tNeuron),
      ],
      verify: (_) {
        verify(() => mockDeactivateNeuron(const DeactivateNeuronParams(id: 'neuron-1'))).called(1);
      },
    );
  });

  group('Filter Neurons Event', () {
    blocTest<NeuronBloc, NeuronState>(
      'should emit filtered neurons based on type',
      build: () => bloc,
      seed: () => NeuronLoaded(neurons: tNeuralNodes),
      act: (bloc) => bloc.add(const FilterNeuronsEvent(type: NeuronType.cortical)),
      expect: () => [
        NeuronLoaded(neurons: tNeuralNodes, filter: NeuronType.cortical),
      ],
    );

    blocTest<NeuronBloc, NeuronState>(
      'should show all neurons when filter is cleared',
      build: () => bloc,
      seed: () => NeuronLoaded(neurons: tNeuralNodes, filter: NeuronType.cortical),
      act: (bloc) => bloc.add(const ClearFilterEvent()),
      expect: () => [
        NeuronLoaded(neurons: tNeuralNodes),
      ],
    );
  });
}
