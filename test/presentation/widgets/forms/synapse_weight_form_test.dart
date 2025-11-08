import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/presentation/widgets/forms/synapse_weight_form.dart';

/// 🔴 RED PHASE - Synapse Weight Form Tests

void main() {
  Widget createWidgetUnderTest({
    double? initialWeight,
    Function(double)? onSubmit,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: SynapseWeightForm(
          initialWeight: initialWeight,
          onSubmit: onSubmit,
        ),
      ),
    );
  }

  group('SynapseWeightForm Widget', () {
    group('Form Rendering', () {
      testWidgets('should display weight input field', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byType(TextField), findsOneWidget);
        expect(find.text('Weight'), findsOneWidget);
      });

      testWidgets('should display slider for weight selection', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byType(Slider), findsOneWidget);
      });

      testWidgets('should display submit button', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.text('Update Weight'), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
      });

      testWidgets('should display current weight value', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(initialWeight: 0.75));

        expect(find.text('0.75'), findsOneWidget);
      });
    });

    group('Input Validation', () {
      testWidgets('should show error for weight below 0', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(find.byType(TextField), '-0.1');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(find.text('Weight must be between 0 and 1'), findsOneWidget);
      });

      testWidgets('should show error for weight above 1', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(find.byType(TextField), '1.5');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(find.text('Weight must be between 0 and 1'), findsOneWidget);
      });

      testWidgets('should show error for invalid number format', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(find.byType(TextField), 'abc');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(find.text('Please enter a valid number'), findsOneWidget);
      });

      testWidgets('should accept valid weight values', (tester) async {
        // This test will FAIL

        var submittedWeight = 0.0;

        await tester.pumpWidget(createWidgetUnderTest(
          onSubmit: (weight) => submittedWeight = weight,
        ));

        await tester.enterText(find.byType(TextField), '0.75');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(submittedWeight, 0.75);
      });
    });

    group('Slider Interaction', () {
      testWidgets('should update text field when slider changes', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.drag(find.byType(Slider), const Offset(100, 0));
        await tester.pumpAndSettle();

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(double.parse(textField.controller!.text), greaterThan(0));
      });

      testWidgets('should update slider when text field changes', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.enterText(find.byType(TextField), '0.8');
        await tester.pumpAndSettle();

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.value, 0.8);
      });

      testWidgets('should show live preview of weight', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.drag(find.byType(Slider), const Offset(100, 0));
        await tester.pumpAndSettle();

        expect(find.byType(WeightPreview), findsOneWidget);
      });
    });

    group('Visual Indicators', () {
      testWidgets('should show strength indicator for weight', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(initialWeight: 0.8));

        expect(find.text('Strong'), findsOneWidget);
        expect(find.byIcon(Icons.check_circle), findsOneWidget);
      });

      testWidgets('should show weak indicator for low weight', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(initialWeight: 0.2));

        expect(find.text('Weak'), findsOneWidget);
        expect(find.byIcon(Icons.warning), findsOneWidget);
      });

      testWidgets('should use color coding for weight strength', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(initialWeight: 0.8));

        final strengthIndicator = tester.widget<Container>(
          find.byKey(const Key('strength_indicator')),
        );
        final decoration = strengthIndicator.decoration as BoxDecoration;
        expect(decoration.color, Colors.green);
      });
    });

    group('Form Submission', () {
      testWidgets('should call onSubmit with correct value', (tester) async {
        // This test will FAIL

        var submittedWeight = 0.0;

        await tester.pumpWidget(createWidgetUnderTest(
          onSubmit: (weight) => submittedWeight = weight,
        ));

        await tester.enterText(find.byType(TextField), '0.65');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(submittedWeight, 0.65);
      });

      testWidgets('should show loading indicator during submission', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(
          onSubmit: (weight) async {
            await Future.delayed(const Duration(seconds: 1));
          },
        ));

        await tester.enterText(find.byType(TextField), '0.5');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('should disable form during submission', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(
          onSubmit: (weight) async {
            await Future.delayed(const Duration(seconds: 1));
          },
        ));

        await tester.enterText(find.byType(TextField), '0.5');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        final button = tester.widget<ElevatedButton>(
          find.byType(ElevatedButton),
        );
        expect(button.enabled, false);
      });
    });

    group('Keyboard Shortcuts', () {
      testWidgets('should submit on enter key', (tester) async {
        // This test will FAIL

        var submitted = false;

        await tester.pumpWidget(createWidgetUnderTest(
          onSubmit: (_) => submitted = true,
        ));

        await tester.enterText(find.byType(TextField), '0.5');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        expect(submitted, true);
      });

      testWidgets('should support arrow keys for fine-tuning', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(initialWeight: 0.5));

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
        await tester.pumpAndSettle();

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(double.parse(textField.controller!.text), greaterThan(0.5));
      });
    });

    group('Accessibility', () {
      testWidgets('should have semantic labels', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest());

        expect(
          find.bySemanticsLabel('Synapse weight input'),
          findsOneWidget,
        );
      });

      testWidgets('should announce value changes to screen readers', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.drag(find.byType(Slider), const Offset(100, 0));
        await tester.pumpAndSettle();

        expect(find.bySemanticsLabel(RegExp('Weight.*changed')), findsOneWidget);
      });
    });

    group('Cancel Action', () {
      testWidgets('should have cancel button', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.text('Cancel'), findsOneWidget);
      });

      testWidgets('should reset form on cancel', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest(initialWeight: 0.5));

        await tester.enterText(find.byType(TextField), '0.8');
        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.controller!.text, '0.5');
      });
    });

    group('Help Text', () {
      testWidgets('should display helper text', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest());

        expect(
          find.text('Enter a value between 0 (weak) and 1 (strong)'),
          findsOneWidget,
        );
      });

      testWidgets('should show tooltip on info icon', (tester) async {
        // This test will FAIL

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.tap(find.byIcon(Icons.info_outline));
        await tester.pumpAndSettle();

        expect(
          find.text('Synapse weight determines connection strength'),
          findsOneWidget,
        );
      });
    });
  });
}
