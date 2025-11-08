import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:synapse_monitor/domain/entities/metric_history.dart';
import 'package:synapse_monitor/presentation/widgets/activation_chart.dart';

/// 🔴 RED PHASE - ActivationChart Widget Tests

void main() {
  final tDataPoints = [
    DataPoint(
      timestamp: DateTime(2025, 11, 8, 10, 0),
      value: 45.0,
    ),
    DataPoint(
      timestamp: DateTime(2025, 11, 8, 10, 5),
      value: 52.0,
    ),
    DataPoint(
      timestamp: DateTime(2025, 11, 8, 10, 10),
      value: 48.0,
    ),
    DataPoint(
      timestamp: DateTime(2025, 11, 8, 10, 15),
      value: 65.0,
    ),
    DataPoint(
      timestamp: DateTime(2025, 11, 8, 10, 20),
      value: 58.0,
    ),
  ];

  final tMetricHistory = MetricHistory(
    metricName: 'activation_level',
    dataPoints: tDataPoints,
    unit: '%',
  );

  Widget createWidgetUnderTest({
    required MetricHistory data,
    ChartType? chartType,
    Duration? timeRange,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: ActivationChart(
          data: data,
          chartType: chartType ?? ChartType.line,
          timeRange: timeRange,
        ),
      ),
    );
  }

  group('ActivationChart Widget', () {
    group('Chart Rendering', () {
      testWidgets('should render line chart', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(
          data: tMetricHistory,
          chartType: ChartType.line,
        ));

        expect(find.byType(LineChart), findsOneWidget);
      });

      testWidgets('should render bar chart', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(
          data: tMetricHistory,
          chartType: ChartType.bar,
        ));

        expect(find.byType(BarChart), findsOneWidget);
      });

      testWidgets('should render area chart', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(
          data: tMetricHistory,
          chartType: ChartType.area,
        ));

        expect(find.byType(LineChart), findsOneWidget);
        final chart = tester.widget<LineChart>(find.byType(LineChart));
        expect(chart.data.lineBarsData.first.isCurved, true);
        expect(chart.data.lineBarsData.first.barWidth, greaterThan(0));
      });

      testWidgets('should display all data points', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(data: tMetricHistory));

        final chart = tester.widget<LineChart>(find.byType(LineChart));
        expect(chart.data.lineBarsData.first.spots.length, 5);
      });

      testWidgets('should use correct colors for chart', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(data: tMetricHistory));

        final chart = tester.widget<LineChart>(find.byType(LineChart));
        expect(chart.data.lineBarsData.first.color, isA<Color>());
      });
    });

    group('Axes and Labels', () {
      testWidgets('should display X-axis labels with timestamps', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(data: tMetricHistory));

        expect(find.text('10:00'), findsOneWidget);
        expect(find.text('10:20'), findsOneWidget);
      });

      testWidgets('should display Y-axis labels with values', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(data: tMetricHistory));

        expect(find.text('0'), findsOneWidget);
        expect(find.text('100'), findsOneWidget);
      });

      testWidgets('should show unit in Y-axis label', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(data: tMetricHistory));

        expect(find.textContaining('%'), findsWidgets);
      });

      testWidgets('should display grid lines', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(data: tMetricHistory));

        final chart = tester.widget<LineChart>(find.byType(LineChart));
        expect(chart.data.gridData.show, true);
      });
    });

    group('Interactions', () {
      testWidgets('should show tooltip on tap', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(data: tMetricHistory));

        await tester.tapAt(const Offset(200, 200));
        await tester.pumpAndSettle();

        expect(find.byType(ChartTooltip), findsOneWidget);
      });

      testWidgets('should display value in tooltip', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(data: tMetricHistory));

        await tester.tapAt(const Offset(200, 200));
        await tester.pumpAndSettle();

        expect(find.textContaining('%'), findsOneWidget);
      });

      testWidgets('should display timestamp in tooltip', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(data: tMetricHistory));

        await tester.tapAt(const Offset(200, 200));
        await tester.pumpAndSettle();

        expect(find.textContaining('10:'), findsOneWidget);
      });

      testWidgets('should support pinch to zoom', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(data: tMetricHistory));

        final center = tester.getCenter(find.byType(ActivationChart));
        await tester.startGesture(center);
        await tester.startGesture(center + const Offset(50, 0));
        await tester.pumpAndSettle();

        expect(find.byType(InteractiveViewer), findsOneWidget);
      });

      testWidgets('should support panning', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(data: tMetricHistory));

        await tester.drag(
          find.byType(ActivationChart),
          const Offset(100, 0),
        );
        await tester.pumpAndSettle();

        expect(find.byType(ActivationChart), findsOneWidget);
      });
    });

    group('Time Range Filtering', () {
      testWidgets('should filter data by time range', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(
          data: tMetricHistory,
          timeRange: const Duration(minutes: 10),
        ));

        final chart = tester.widget<LineChart>(find.byType(LineChart));
        expect(chart.data.lineBarsData.first.spots.length, lessThan(5));
      });

      testWidgets('should show last hour by default', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(data: tMetricHistory));

        expect(find.byType(LineChart), findsOneWidget);
      });
    });

    group('Threshold Lines', () {
      testWidgets('should display warning threshold line', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActivationChart(
                data: tMetricHistory,
                warningThreshold: 60.0,
              ),
            ),
          ),
        );

        final chart = tester.widget<LineChart>(find.byType(LineChart));
        expect(chart.data.extraLinesData.horizontalLines.length, greaterThan(0));
      });

      testWidgets('should display critical threshold line', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActivationChart(
                data: tMetricHistory,
                criticalThreshold: 80.0,
              ),
            ),
          ),
        );

        final chart = tester.widget<LineChart>(find.byType(LineChart));
        expect(chart.data.extraLinesData.horizontalLines.length, greaterThan(0));
      });

      testWidgets('should use different colors for thresholds', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActivationChart(
                data: tMetricHistory,
                warningThreshold: 60.0,
                criticalThreshold: 80.0,
              ),
            ),
          ),
        );

        final chart = tester.widget<LineChart>(find.byType(LineChart));
        final lines = chart.data.extraLinesData.horizontalLines;
        expect(lines[0].color, isNot(equals(lines[1].color)));
      });
    });

    group('Statistics Overlay', () {
      testWidgets('should display min/max/avg values', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActivationChart(
                data: tMetricHistory,
                showStatistics: true,
              ),
            ),
          ),
        );

        expect(find.text('Min:'), findsOneWidget);
        expect(find.text('Max:'), findsOneWidget);
        expect(find.text('Avg:'), findsOneWidget);
      });

      testWidgets('should display trend indicator', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActivationChart(
                data: tMetricHistory,
                showTrend: true,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.trending_up), findsOneWidget);
      });
    });

    group('Empty State', () {
      testWidgets('should display empty state when no data', (tester) async {
        // This test will FAIL

        final emptyHistory = MetricHistory(
          metricName: 'test',
          dataPoints: [],
          unit: '%',
        );

        await tester.pumpWidget(createWidgetUnderTest(data: emptyHistory));

        expect(find.text('No data available'), findsOneWidget);
        expect(find.byIcon(Icons.show_chart), findsOneWidget);
      });
    });

    group('Loading State', () {
      testWidgets('should display loading indicator', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActivationChart(
                data: null,
                isLoading: true,
              ),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('Animations', () {
      testWidgets('should animate chart on initial render', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(data: tMetricHistory));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(AnimatedBuilder), findsOneWidget);
      });

      testWidgets('should animate data updates', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(data: tMetricHistory));

        final updatedData = MetricHistory(
          metricName: 'activation_level',
          dataPoints: [
            ...tDataPoints,
            DataPoint(
              timestamp: DateTime(2025, 11, 8, 10, 25),
              value: 70.0,
            ),
          ],
          unit: '%',
        );

        await tester.pumpWidget(createWidgetUnderTest(data: updatedData));
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(AnimatedBuilder), findsOneWidget);
      });
    });

    group('Customization', () {
      testWidgets('should support custom colors', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActivationChart(
                data: tMetricHistory,
                lineColor: Colors.purple,
              ),
            ),
          ),
        );

        final chart = tester.widget<LineChart>(find.byType(LineChart));
        expect(chart.data.lineBarsData.first.color, Colors.purple);
      });

      testWidgets('should support custom line width', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ActivationChart(
                data: tMetricHistory,
                lineWidth: 5.0,
              ),
            ),
          ),
        );

        final chart = tester.widget<LineChart>(find.byType(LineChart));
        expect(chart.data.lineBarsData.first.barWidth, 5.0);
      });
    });

    group('Export', () {
      testWidgets('should support export as image', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(data: tMetricHistory));

        final image = await tester.binding.takeScreenshot('chart.png');

        expect(image, isNotNull);
      });
    });
  });
}
