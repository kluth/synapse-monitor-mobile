import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:synapse_monitor/core/error/failures.dart';
import 'package:synapse_monitor/domain/entities/synapse.dart';
import 'package:synapse_monitor/domain/entities/network_graph.dart';
import 'package:synapse_monitor/domain/usecases/get_all_synapses.dart';
import 'package:synapse_monitor/domain/usecases/get_network_graph.dart';
import 'package:synapse_monitor/domain/usecases/update_synapse_weight.dart';
import 'package:synapse_monitor/presentation/blocs/synapse/synapse_bloc.dart';

class MockGetAllSynapses extends Mock implements GetAllSynapses {}
class MockGetNetworkGraph extends Mock implements GetNetworkGraph {}
class MockUpdateSynapseWeight extends Mock implements UpdateSynapseWeight {}

/// 🔴 RED PHASE - SynapseBloc Tests

void main() {
  late SynapseBloc bloc;
  late MockGetAllSynapses mockGetAllSynapses;
  late MockGetNetworkGraph mockGetNetworkGraph;
  late MockUpdateSynapseWeight mockUpdateSynapseWeight;

  setUp(() {
    mockGetAllSynapses = MockGetAllSynapses();
    mockGetNetworkGraph = MockGetNetworkGraph();
    mockUpdateSynapseWeight = MockUpdateSynapseWeight();

    bloc = SynapseBloc(
      getAllSynapses: mockGetAllSynapses,
      getNetworkGraph: mockGetNetworkGraph,
      updateSynapseWeight: mockUpdateSynapseWeight,
    );
  });

  final tSynapses = [
    Synapse(
      id: 'synapse-1',
      sourceNeuronId: 'neuron-1',
      targetNeuronId: 'neuron-2',
      weight: 0.75,
    ),
  ];

  final tNetworkGraph = NetworkGraph(
    nodes: [],
    edges: tSynapses,
  );

  group('Initial State', () {
    test('should have SynapseInitial as initial state', () async {
      // This test will FAIL

      expect(bloc.state, SynapseInitial());
    });
  });

  group('LoadSynapses Event', () {
    blocTest<SynapseBloc, SynapseState>(
      'should emit [Loading, Loaded] when synapses are fetched successfully',
      build: () {
        when(() => mockGetAllSynapses())
            .thenAnswer((_) async => Right(tSynapses));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadSynapsesEvent()),
      expect: () => [
        SynapseLoading(),
        SynapseLoaded(synapses: tSynapses),
      ],
      verify: (_) {
        verify(() => mockGetAllSynapses()).called(1);
      },
    );

    blocTest<SynapseBloc, SynapseState>(
      'should emit [Loading, Error] when fetching fails',
      build: () {
        when(() => mockGetAllSynapses())
            .thenAnswer((_) async => Left(NetworkFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadSynapsesEvent()),
      expect: () => [
        SynapseLoading(),
        isA<SynapseError>(),
      ],
    );
  });

  group('LoadNetworkGraph Event', () {
    blocTest<SynapseBloc, SynapseState>(
      'should emit [Loading, NetworkGraphLoaded] when graph is fetched successfully',
      build: () {
        when(() => mockGetNetworkGraph())
            .thenAnswer((_) async => Right(tNetworkGraph));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadNetworkGraphEvent()),
      expect: () => [
        SynapseLoading(),
        NetworkGraphLoaded(graph: tNetworkGraph),
      ],
      verify: (_) {
        verify(() => mockGetNetworkGraph()).called(1);
      },
    );

    blocTest<SynapseBloc, SynapseState>(
      'should emit [Loading, Error] when graph fetch fails',
      build: () {
        when(() => mockGetNetworkGraph())
            .thenAnswer((_) async => Left(ServerFailure(statusCode: 500)));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadNetworkGraphEvent()),
      expect: () => [
        SynapseLoading(),
        isA<SynapseError>(),
      ],
    );
  });

  group('UpdateSynapseWeight Event', () {
    final updatedSynapse = Synapse(
      id: 'synapse-1',
      sourceNeuronId: 'neuron-1',
      targetNeuronId: 'neuron-2',
      weight: 0.9,
    );

    blocTest<SynapseBloc, SynapseState>(
      'should emit [UpdateInProgress, SynapseUpdated] when update succeeds',
      build: () {
        when(() => mockUpdateSynapseWeight(any()))
            .thenAnswer((_) async => Right(updatedSynapse));
        return bloc;
      },
      act: (bloc) => bloc.add(const UpdateSynapseWeightEvent(
        synapseId: 'synapse-1',
        newWeight: 0.9,
      )),
      expect: () => [
        SynapseUpdateInProgress(),
        SynapseUpdated(synapse: updatedSynapse),
      ],
      verify: (_) {
        verify(() => mockUpdateSynapseWeight(
              const UpdateSynapseWeightParams(id: 'synapse-1', newWeight: 0.9),
            )).called(1);
      },
    );

    blocTest<SynapseBloc, SynapseState>(
      'should emit [UpdateInProgress, Error] when validation fails',
      build: () {
        when(() => mockUpdateSynapseWeight(any()))
            .thenAnswer((_) async => Left(ValidationFailure(message: 'Invalid weight')));
        return bloc;
      },
      act: (bloc) => bloc.add(const UpdateSynapseWeightEvent(
        synapseId: 'synapse-1',
        newWeight: 1.5,
      )),
      expect: () => [
        SynapseUpdateInProgress(),
        isA<SynapseError>(),
      ],
    );
  });

  group('Filter Synapses Event', () {
    blocTest<SynapseBloc, SynapseState>(
      'should emit filtered synapses by strength',
      build: () => bloc,
      seed: () => SynapseLoaded(synapses: tSynapses),
      act: (bloc) => bloc.add(const FilterSynapsesByStrengthEvent(
        minWeight: 0.7,
      )),
      expect: () => [
        SynapseLoaded(synapses: tSynapses, minWeight: 0.7),
      ],
    );

    blocTest<SynapseBloc, SynapseState>(
      'should clear filter and show all synapses',
      build: () => bloc,
      seed: () => SynapseLoaded(synapses: tSynapses, minWeight: 0.7),
      act: (bloc) => bloc.add(const ClearSynapseFilterEvent()),
      expect: () => [
        SynapseLoaded(synapses: tSynapses),
      ],
    );
  });
}
