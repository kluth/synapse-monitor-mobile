import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:synapse_monitor/domain/entities/neural_node.dart';
import 'package:synapse_monitor/presentation/features/search/search_delegate.dart';
import 'package:synapse_monitor/presentation/features/search/search_service.dart';

class MockSearchService extends Mock implements SearchService {}

/// 🔴 RED PHASE - Search Feature Tests

void main() {
  late MockSearchService mockSearchService;

  setUp(() {
    mockSearchService = MockSearchService();
  });

  final tNeurons = [
    NeuralNode(
      id: 'neuron-1',
      name: 'Cortical Node A1',
      type: NeuronType.cortical,
      activationThreshold: 0.7,
      currentActivation: 0.8,
      connectionCount: 10,
    ),
    NeuralNode(
      id: 'neuron-2',
      name: 'Reflex Node R1',
      type: NeuronType.reflex,
      activationThreshold: 0.5,
      currentActivation: 0.6,
      connectionCount: 5,
    ),
  ];

  group('Search Functionality', () {
    group('SearchDelegate', () {
      testWidgets('should display search bar', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: NeuronSearchDelegate(mockSearchService),
                    );
                  },
                  child: const Text('Search'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Search'));
        await tester.pumpAndSettle();

        expect(find.byType(TextField), findsOneWidget);
      });

      testWidgets('should show search suggestions', (tester) async {
        // This test will FAIL

        when(() => mockSearchService.getSuggestions(any()))
            .thenAnswer((_) async => ['Cortical', 'Reflex', 'Sensory']);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: NeuronSearchDelegate(mockSearchService),
                    );
                  },
                  child: const Text('Search'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Search'));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'Cor');
        await tester.pumpAndSettle();

        expect(find.text('Cortical'), findsOneWidget);
        expect(find.text('Reflex'), findsOneWidget);
      });

      testWidgets('should perform search on submit', (tester) async {
        // This test will FAIL

        when(() => mockSearchService.search(any()))
            .thenAnswer((_) async => tNeurons);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: NeuronSearchDelegate(mockSearchService),
                    );
                  },
                  child: const Text('Search'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Search'));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'Cortical');
        await tester.testTextInput.receiveAction(TextInputAction.search);
        await tester.pumpAndSettle();

        expect(find.text('Cortical Node A1'), findsOneWidget);
      });

      testWidgets('should display recent searches', (tester) async {
        // This test will FAIL

        when(() => mockSearchService.getRecentSearches())
            .thenReturn(['Cortical', 'Reflex']);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: NeuronSearchDelegate(mockSearchService),
                    );
                  },
                  child: const Text('Search'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Search'));
        await tester.pumpAndSettle();

        expect(find.text('Recent'), findsOneWidget);
        expect(find.text('Cortical'), findsOneWidget);
        expect(find.text('Reflex'), findsOneWidget);
      });

      testWidgets('should clear search query', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: NeuronSearchDelegate(mockSearchService),
                    );
                  },
                  child: const Text('Search'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Search'));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), 'test');
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.clear));
        await tester.pumpAndSettle();

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.controller!.text, isEmpty);
      });
    });

    group('Search Service', () {
      test('should search by name', () async {
        // This test will FAIL

        final searchService = SearchService();
        searchService.setData(tNeurons);

        final results = await searchService.search('Cortical');

        expect(results.length, 1);
        expect(results.first.name, 'Cortical Node A1');
      });

      test('should search case-insensitively', () async {
        // This test will FAIL

        final searchService = SearchService();
        searchService.setData(tNeurons);

        final results = await searchService.search('cortical');

        expect(results.length, 1);
      });

      test('should search by multiple fields', () async {
        // This test will FAIL

        final searchService = SearchService();
        searchService.setData(tNeurons);

        final results = await searchService.search('reflex');

        expect(results.length, 1);
        expect(results.first.type, NeuronType.reflex);
      });

      test('should return empty list for no matches', () async {
        // This test will FAIL

        final searchService = SearchService();
        searchService.setData(tNeurons);

        final results = await searchService.search('nonexistent');

        expect(results, isEmpty);
      });

      test('should support fuzzy search', () async {
        // This test will FAIL

        final searchService = SearchService(enableFuzzySearch: true);
        searchService.setData(tNeurons);

        final results = await searchService.search('Cortcal'); // Typo

        expect(results.length, greaterThan(0));
      });

      test('should rank results by relevance', () async {
        // This test will FAIL

        final searchService = SearchService();
        searchService.setData([
          ...tNeurons,
          NeuralNode(
            id: 'neuron-3',
            name: 'Cortical Complex Node',
            type: NeuronType.cortical,
            activationThreshold: 0.7,
            currentActivation: 0.8,
            connectionCount: 10,
          ),
        ]);

        final results = await searchService.search('Cortical');

        expect(results.first.name, 'Cortical Node A1'); // Exact match first
      });

      test('should save search to history', () async {
        // This test will FAIL

        final searchService = SearchService();

        await searchService.search('Cortical');

        final history = searchService.getRecentSearches();
        expect(history, contains('Cortical'));
      });

      test('should limit search history size', () async {
        // This test will FAIL

        final searchService = SearchService(maxHistorySize: 5);

        for (var i = 0; i < 10; i++) {
          await searchService.search('query$i');
        }

        final history = searchService.getRecentSearches();
        expect(history.length, 5);
      });

      test('should clear search history', () async {
        // This test will FAIL

        final searchService = SearchService();

        await searchService.search('test');
        searchService.clearHistory();

        final history = searchService.getRecentSearches();
        expect(history, isEmpty);
      });
    });

    group('Search Filters', () {
      test('should filter by neuron type', () async {
        // This test will FAIL

        final searchService = SearchService();
        searchService.setData(tNeurons);

        final results = await searchService.search(
          'Node',
          filters: {'type': NeuronType.cortical},
        );

        expect(results.length, 1);
        expect(results.first.type, NeuronType.cortical);
      });

      test('should filter by activation level', () async {
        // This test will FAIL

        final searchService = SearchService();
        searchService.setData(tNeurons);

        final results = await searchService.search(
          '',
          filters: {'minActivation': 0.7},
        );

        expect(results.every((n) => n.currentActivation >= 0.7), true);
      });

      test('should filter by connection count', () async {
        // This test will FAIL

        final searchService = SearchService();
        searchService.setData(tNeurons);

        final results = await searchService.search(
          '',
          filters: {'minConnections': 8},
        );

        expect(results.every((n) => n.connectionCount >= 8), true);
      });

      test('should combine multiple filters', () async {
        // This test will FAIL

        final searchService = SearchService();
        searchService.setData(tNeurons);

        final results = await searchService.search(
          'Node',
          filters: {
            'type': NeuronType.cortical,
            'minActivation': 0.7,
          },
        );

        expect(results.length, 1);
      });
    });

    group('Search Highlighting', () {
      test('should highlight search terms in results', () async {
        // This test will FAIL

        final searchService = SearchService();
        searchService.setData(tNeurons);

        final results = await searchService.searchWithHighlighting('Cortical');

        expect(results.first.highlighted, contains('<mark>Cortical</mark>'));
      });

      test('should highlight multiple occurrences', () async {
        // This test will FAIL

        final searchService = SearchService();
        searchService.setData([
          NeuralNode(
            id: 'neuron-1',
            name: 'Cortical Cortical Node',
            type: NeuronType.cortical,
            activationThreshold: 0.7,
            currentActivation: 0.8,
            connectionCount: 10,
          ),
        ]);

        final results = await searchService.searchWithHighlighting('Cortical');

        expect('<mark>'.allMatches(results.first.highlighted).length, 2);
      });
    });

    group('Search Performance', () {
      test('should debounce search queries', () async {
        // This test will FAIL

        final searchService = SearchService(debounceMs: 300);
        var callCount = 0;

        searchService.onSearch = (_) => callCount++;

        searchService.search('C');
        searchService.search('Co');
        searchService.search('Cor');

        await Future.delayed(const Duration(milliseconds: 100));
        expect(callCount, 0); // No search yet due to debounce

        await Future.delayed(const Duration(milliseconds: 300));
        expect(callCount, 1); // Only one search after debounce
      });

      test('should cache search results', () async {
        // This test will FAIL

        final searchService = SearchService(enableCache: true);
        searchService.setData(tNeurons);

        await searchService.search('Cortical');
        final cachedResult = await searchService.search('Cortical');

        expect(searchService.cacheHits, 1);
      });

      test('should handle large datasets efficiently', () async {
        // This test will FAIL

        final searchService = SearchService();
        final largeDataset = List.generate(10000, (i) => NeuralNode(
          id: 'neuron-$i',
          name: 'Node $i',
          type: NeuronType.cortical,
          activationThreshold: 0.7,
          currentActivation: 0.5,
          connectionCount: 5,
        ));

        searchService.setData(largeDataset);

        final stopwatch = Stopwatch()..start();
        await searchService.search('Node 5000');
        stopwatch.stop();

        expect(stopwatch.elapsedMilliseconds, lessThan(100));
      });
    });

    group('Voice Search', () {
      test('should support voice search', () async {
        // This test will FAIL

        final searchService = SearchService();

        final result = await searchService.voiceSearch();

        expect(result, isA<String>());
      });

      test('should convert voice to text', () async {
        // This test will FAIL

        final searchService = SearchService();

        final text = await searchService.convertVoiceToText(mockAudioData);

        expect(text, isNotEmpty);
      });
    });

    group('Search Analytics', () {
      test('should track search queries', () async {
        // This test will FAIL

        final searchService = SearchService();

        await searchService.search('Cortical');

        final analytics = searchService.getAnalytics();
        expect(analytics.totalSearches, 1);
        expect(analytics.topQueries, contains('Cortical'));
      });

      test('should track zero-result searches', () async {
        // This test will FAIL

        final searchService = SearchService();
        searchService.setData(tNeurons);

        await searchService.search('nonexistent');

        final analytics = searchService.getAnalytics();
        expect(analytics.zeroResultSearches, 1);
      });
    });
  });
}
