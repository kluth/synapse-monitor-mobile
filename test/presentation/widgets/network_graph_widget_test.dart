import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/domain/entities/network_graph.dart';
import 'package:synapse_monitor/domain/entities/neural_node.dart';
import 'package:synapse_monitor/domain/entities/synapse.dart';
import 'package:synapse_monitor/presentation/widgets/network_graph_widget.dart';

/// 🔴 RED PHASE - NetworkGraphWidget Tests

void main() {
  final tNodes = [
    NeuralNode(
      id: 'neuron-1',
      name: 'Node 1',
      type: NeuronType.cortical,
      activationThreshold: 0.7,
      currentActivation: 0.8,
      connectionCount: 2,
    ),
    NeuralNode(
      id: 'neuron-2',
      name: 'Node 2',
      type: NeuronType.reflex,
      activationThreshold: 0.6,
      currentActivation: 0.5,
      connectionCount: 2,
    ),
    NeuralNode(
      id: 'neuron-3',
      name: 'Node 3',
      type: NeuronType.sensory,
      activationThreshold: 0.5,
      currentActivation: 0.7,
      connectionCount: 1,
    ),
  ];

  final tEdges = [
    Synapse(
      id: 'synapse-1',
      sourceNeuronId: 'neuron-1',
      targetNeuronId: 'neuron-2',
      weight: 0.8,
    ),
    Synapse(
      id: 'synapse-2',
      sourceNeuronId: 'neuron-2',
      targetNeuronId: 'neuron-3',
      weight: 0.6,
    ),
  ];

  final tGraph = NetworkGraph(
    nodes: tNodes,
    edges: tEdges,
  );

  Widget createWidgetUnderTest({
    required NetworkGraph graph,
    Function(String)? onNodeTap,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: NetworkGraphWidget(
          graph: graph,
          onNodeTap: onNodeTap,
        ),
      ),
    );
  }

  group('NetworkGraphWidget', () {
    group('Graph Rendering', () {
      testWidgets('should render all nodes', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(graph: tGraph));

        expect(find.byType(NetworkNode), findsNWidgets(3));
      });

      testWidgets('should render all edges', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(graph: tGraph));

        expect(find.byType(NetworkEdge), findsNWidgets(2));
      });

      testWidgets('should use CustomPaint for graph rendering', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(graph: tGraph));

        expect(find.byType(CustomPaint), findsOneWidget);
      });

      testWidgets('should color nodes by activation level', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(graph: tGraph));

        final painter = tester.widget<CustomPaint>(
          find.byType(CustomPaint),
        ).painter as NetworkGraphPainter;

        expect(painter.getNodeColor('neuron-1'), Colors.green);
        expect(painter.getNodeColor('neuron-2'), Colors.orange);
      });

      testWidgets('should vary edge thickness by weight', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(graph: tGraph));

        final painter = tester.widget<CustomPaint>(
          find.byType(CustomPaint),
        ).painter as NetworkGraphPainter;

        expect(painter.getEdgeWidth('synapse-1'), greaterThan(
          painter.getEdgeWidth('synapse-2'),
        ));
      });
    });

    group('Interactions', () {
      testWidgets('should call onNodeTap when node is tapped', (tester) async {
        // This test will FAIL

        String? tappedNodeId;

        await tester.pumpWidget(createWidgetUnderTest(
          graph: tGraph,
          onNodeTap: (id) => tappedNodeId = id,
        ));

        await tester.tapAt(const Offset(100, 100));
        await tester.pumpAndSettle();

        expect(tappedNodeId, isNotNull);
      });

      testWidgets('should highlight node on hover', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(graph: tGraph));

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: const Offset(100, 100));
        await tester.pumpAndSettle();

        expect(find.byType(NodeHighlight), findsOneWidget);
      });

      testWidgets('should show node details on long press', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(graph: tGraph));

        await tester.longPressAt(const Offset(100, 100));
        await tester.pumpAndSettle();

        expect(find.byType(NodeDetailsPopup), findsOneWidget);
      });
    });

    group('Zoom and Pan', () {
      testWidgets('should support pinch to zoom', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(graph: tGraph));

        final center = tester.getCenter(find.byType(NetworkGraphWidget));
        await tester.startGesture(center);
        await tester.startGesture(center + const Offset(50, 50));
        await tester.pumpAndSettle();

        expect(find.byType(InteractiveViewer), findsOneWidget);
      });

      testWidgets('should support panning', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(graph: tGraph));

        await tester.drag(
          find.byType(NetworkGraphWidget),
          const Offset(100, 0),
        );
        await tester.pumpAndSettle();

        final viewer = tester.widget<InteractiveViewer>(
          find.byType(InteractiveViewer),
        );
        expect(viewer.transformationController, isNotNull);
      });

      testWidgets('should reset zoom on double tap', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(graph: tGraph));

        await tester.tap(find.byType(NetworkGraphWidget));
        await tester.pump(const Duration(milliseconds: 100));
        await tester.tap(find.byType(NetworkGraphWidget));
        await tester.pumpAndSettle();

        final viewer = tester.widget<InteractiveViewer>(
          find.byType(InteractiveViewer),
        );
        expect(viewer.transformationController?.value.getMaxScaleOnAxis(), 1.0);
      });
    });

    group('Layout Algorithms', () {
      testWidgets('should support force-directed layout', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NetworkGraphWidget(
                graph: tGraph,
                layoutAlgorithm: LayoutAlgorithm.forceDirected,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(NetworkGraphWidget), findsOneWidget);
      });

      testWidgets('should support circular layout', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NetworkGraphWidget(
                graph: tGraph,
                layoutAlgorithm: LayoutAlgorithm.circular,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(NetworkGraphWidget), findsOneWidget);
      });

      testWidgets('should support hierarchical layout', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NetworkGraphWidget(
                graph: tGraph,
                layoutAlgorithm: LayoutAlgorithm.hierarchical,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(NetworkGraphWidget), findsOneWidget);
      });
    });

    group('Animations', () {
      testWidgets('should animate layout changes', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(graph: tGraph));

        final updatedGraph = NetworkGraph(
          nodes: [...tNodes, NeuralNode(
            id: 'neuron-4',
            name: 'Node 4',
            type: NeuronType.motor,
            activationThreshold: 0.6,
            currentActivation: 0.7,
            connectionCount: 1,
          )],
          edges: tEdges,
        );

        await tester.pumpWidget(createWidgetUnderTest(graph: updatedGraph));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(AnimatedPositioned), findsWidgets);
      });

      testWidgets('should animate edge weight changes', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(graph: tGraph));

        final updatedEdges = [
          Synapse(
            id: 'synapse-1',
            sourceNeuronId: 'neuron-1',
            targetNeuronId: 'neuron-2',
            weight: 0.95, // Increased weight
          ),
          ...tEdges.skip(1),
        ];

        final updatedGraph = NetworkGraph(
          nodes: tNodes,
          edges: updatedEdges,
        );

        await tester.pumpWidget(createWidgetUnderTest(graph: updatedGraph));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(AnimatedContainer), findsWidgets);
      });
    });

    group('Performance', () {
      testWidgets('should handle large graphs efficiently', (tester) async {
        // This test will FAIL

        final largeNodes = List.generate(100, (i) => NeuralNode(
          id: 'neuron-$i',
          name: 'Node $i',
          type: NeuronType.cortical,
          activationThreshold: 0.7,
          currentActivation: 0.5,
          connectionCount: 2,
        ));

        final largeEdges = List.generate(150, (i) => Synapse(
          id: 'synapse-$i',
          sourceNeuronId: 'neuron-${i % 100}',
          targetNeuronId: 'neuron-${(i + 1) % 100}',
          weight: 0.5,
        ));

        final largeGraph = NetworkGraph(
          nodes: largeNodes,
          edges: largeEdges,
        );

        await tester.pumpWidget(createWidgetUnderTest(graph: largeGraph));
        await tester.pumpAndSettle();

        expect(find.byType(NetworkGraphWidget), findsOneWidget);
      });

      testWidgets('should use level of detail rendering', (tester) async {
        // This test will FAIL

        final largeGraph = NetworkGraph(
          nodes: List.generate(100, (i) => NeuralNode(
            id: 'neuron-$i',
            name: 'Node $i',
            type: NeuronType.cortical,
            activationThreshold: 0.7,
            currentActivation: 0.5,
            connectionCount: 2,
          )),
          edges: [],
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NetworkGraphWidget(
                graph: largeGraph,
                useLevelOfDetail: true,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(NetworkGraphWidget), findsOneWidget);
      });
    });

    group('Filtering and Highlighting', () {
      testWidgets('should highlight selected nodes', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NetworkGraphWidget(
                graph: tGraph,
                highlightedNodeIds: {'neuron-1'},
              ),
            ),
          ),
        );

        expect(find.byType(NodeHighlight), findsOneWidget);
      });

      testWidgets('should dim unselected nodes when filtering', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NetworkGraphWidget(
                graph: tGraph,
                filterNodeType: NeuronType.cortical,
              ),
            ),
          ),
        );

        final painter = tester.widget<CustomPaint>(
          find.byType(CustomPaint),
        ).painter as NetworkGraphPainter;

        expect(painter.getNodeOpacity('neuron-1'), 1.0);
        expect(painter.getNodeOpacity('neuron-2'), lessThan(1.0));
      });
    });

    group('Legend', () {
      testWidgets('should display legend', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NetworkGraphWidget(
                graph: tGraph,
                showLegend: true,
              ),
            ),
          ),
        );

        expect(find.text('Cortical'), findsOneWidget);
        expect(find.text('Reflex'), findsOneWidget);
        expect(find.text('Sensory'), findsOneWidget);
      });
    });

    group('Export', () {
      testWidgets('should support export as image', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(graph: tGraph));

        final image = await tester.binding.takeScreenshot('graph.png');

        expect(image, isNotNull);
      });
    });
  });
}
