import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/core/utils/string_utils.dart';

/// 🔴 RED PHASE - StringUtils Tests

void main() {
  group('StringUtils', () {
    group('capitalize', () {
      test('should capitalize first letter of string', () async {
        // This test will FAIL

        expect(StringUtils.capitalize('hello'), 'Hello');
        expect(StringUtils.capitalize('world'), 'World');
      });

      test('should handle empty string', () async {
        // This test will FAIL

        expect(StringUtils.capitalize(''), '');
      });

      test('should handle single character', () async {
        // This test will FAIL

        expect(StringUtils.capitalize('a'), 'A');
      });
    });

    group('truncate', () {
      test('should truncate long strings', () async {
        // This test will FAIL

        expect(
          StringUtils.truncate('This is a very long string', maxLength: 10),
          'This is a...',
        );
      });

      test('should not truncate short strings', () async {
        // This test will FAIL

        expect(
          StringUtils.truncate('Short', maxLength: 10),
          'Short',
        );
      });

      test('should use custom ellipsis', () async {
        // This test will FAIL

        expect(
          StringUtils.truncate('Long string', maxLength: 5, ellipsis: '---'),
          'Long ---',
        );
      });
    });

    group('toTitleCase', () {
      test('should convert to title case', () async {
        // This test will FAIL

        expect(StringUtils.toTitleCase('hello world'), 'Hello World');
        expect(StringUtils.toTitleCase('neural network'), 'Neural Network');
      });

      test('should handle single word', () async {
        // This test will FAIL

        expect(StringUtils.toTitleCase('test'), 'Test');
      });
    });

    group('toCamelCase', () {
      test('should convert to camel case', () async {
        // This test will FAIL

        expect(StringUtils.toCamelCase('hello world'), 'helloWorld');
        expect(StringUtils.toCamelCase('neural network monitor'), 'neuralNetworkMonitor');
      });
    });

    group('toSnakeCase', () {
      test('should convert to snake case', () async {
        // This test will FAIL

        expect(StringUtils.toSnakeCase('helloWorld'), 'hello_world');
        expect(StringUtils.toSnakeCase('NeuralNetwork'), 'neural_network');
      });
    });

    group('removeWhitespace', () {
      test('should remove all whitespace', () async {
        // This test will FAIL

        expect(StringUtils.removeWhitespace('hello world'), 'helloworld');
        expect(StringUtils.removeWhitespace('  test  '), 'test');
      });
    });

    group('isNumeric', () {
      test('should return true for numeric strings', () async {
        // This test will FAIL

        expect(StringUtils.isNumeric('123'), true);
        expect(StringUtils.isNumeric('45.67'), true);
        expect(StringUtils.isNumeric('-89'), true);
      });

      test('should return false for non-numeric strings', () async {
        // This test will FAIL

        expect(StringUtils.isNumeric('abc'), false);
        expect(StringUtils.isNumeric('12a3'), false);
      });
    });

    group('containsIgnoreCase', () {
      test('should find substring ignoring case', () async {
        // This test will FAIL

        expect(StringUtils.containsIgnoreCase('Hello World', 'WORLD'), true);
        expect(StringUtils.containsIgnoreCase('Neural Network', 'neural'), true);
      });

      test('should return false when substring not found', () async {
        // This test will FAIL

        expect(StringUtils.containsIgnoreCase('Hello', 'xyz'), false);
      });
    });

    group('pluralize', () {
      test('should add "s" for count > 1', () async {
        // This test will FAIL

        expect(StringUtils.pluralize('neuron', 2), 'neurons');
        expect(StringUtils.pluralize('synapse', 5), 'synapses');
      });

      test('should not pluralize for count = 1', () async {
        // This test will FAIL

        expect(StringUtils.pluralize('neuron', 1), 'neuron');
      });

      test('should use custom plural form', () async {
        // This test will FAIL

        expect(
          StringUtils.pluralize('child', 2, pluralForm: 'children'),
          'children',
        );
      });
    });

    group('extractNumbers', () {
      test('should extract all numbers from string', () async {
        // This test will FAIL

        expect(StringUtils.extractNumbers('neuron-123-synapse-456'), ['123', '456']);
      });

      test('should return empty list when no numbers', () async {
        // This test will FAIL

        expect(StringUtils.extractNumbers('hello world'), isEmpty);
      });
    });
  });
}
