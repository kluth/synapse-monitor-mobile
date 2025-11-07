import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/features/glial_cells/data/models/astrocyte_stats_model.dart';
import 'package:synapse_monitor/features/glial_cells/domain/entities/astrocyte_stats.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  group('AstrocyteStatsModel', () {
    final tAstrocyteStatsModel = AstrocyteStatsModel(
      cacheSize: 750,
      capacity: 1000,
      hitRate: 85.5,
      missRate: 14.5,
      averageTTLMs: 300000,
      namespaceDistribution: const {
        'users': 350,
        'sessions': 250,
        'products': 150,
      },
      evictionCount: 125,
      patternMatchOperations: 450,
      timestamp: DateTime.parse('2025-11-07T12:00:00Z'),
    );

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Arrange
        final jsonMap = json.decode(fixture('astrocyte_stats.json'))
            as Map<String, dynamic>;

        // Act
        final result = AstrocyteStatsModel.fromJson(jsonMap);

        // Assert
        expect(result, equals(tAstrocyteStatsModel));
      });

      test('should handle missing optional fields', () {
        // Arrange
        final jsonMap = {
          'cacheSize': 750,
          'capacity': 1000,
          'hitRate': 85.5,
          'missRate': 14.5,
          'averageTTLMs': 300000,
          'namespaceDistribution': {
            'users': 350,
          },
          'evictionCount': 125,
        };

        // Act
        final result = AstrocyteStatsModel.fromJson(jsonMap);

        // Assert
        expect(result.cacheSize, equals(750));
        expect(result.patternMatchOperations, isNull);
        expect(result.timestamp, isNull);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // Act
        final result = tAstrocyteStatsModel.toJson();

        // Assert
        final expectedMap = {
          'cacheSize': 750,
          'capacity': 1000,
          'hitRate': 85.5,
          'missRate': 14.5,
          'averageTTLMs': 300000,
          'namespaceDistribution': {
            'users': 350,
            'sessions': 250,
            'products': 150,
          },
          'evictionCount': 125,
          'patternMatchOperations': 450,
          'timestamp': '2025-11-07T12:00:00.000Z',
        };

        expect(result, equals(expectedMap));
      });

      test('should handle null optional fields in JSON output', () {
        // Arrange
        final model = AstrocyteStatsModel(
          cacheSize: 500,
          capacity: 1000,
          hitRate: 75.0,
          missRate: 25.0,
          averageTTLMs: 200000,
          namespaceDistribution: const {'test': 500},
          evictionCount: 50,
          patternMatchOperations: null,
          timestamp: null,
        );

        // Act
        final result = model.toJson();

        // Assert
        expect(result['patternMatchOperations'], isNull);
        expect(result['timestamp'], isNull);
      });
    });

    group('toEntity', () {
      test('should convert model to AstrocyteStats entity', () {
        // Act
        final result = tAstrocyteStatsModel.toEntity();

        // Assert
        expect(result, isA<AstrocyteStats>());
        expect(result.cacheSize, equals(750));
        expect(result.capacity, equals(1000));
        expect(result.hitRate, equals(85.5));
        expect(result.missRate, equals(14.5));
        expect(
          result.averageTTL,
          equals(const Duration(milliseconds: 300000)),
        );
        expect(result.namespaceDistribution, equals({
          'users': 350,
          'sessions': 250,
          'products': 150,
        }));
        expect(result.evictionCount, equals(125));
        expect(result.patternMatchOperations, equals(450));
        expect(
          result.timestamp,
          equals(DateTime.parse('2025-11-07T12:00:00Z')),
        );
      });

      test('should preserve entity computed properties', () {
        // Act
        final result = tAstrocyteStatsModel.toEntity();

        // Assert
        // utilizationPercentage = (750 / 1000) * 100 = 75.0%
        expect(result.utilizationPercentage, equals(75.0));
        expect(result.isNearlyFull, isFalse); // 75% <= 80%
        expect(result.isFull, isFalse); // 750 < 1000
        expect(result.hasHealthyHitRate, isTrue); // 85.5% > 70%
        expect(result.hasCriticalHitRate, isFalse); // 85.5% >= 30%
        expect(result.mostUsedNamespace, equals('users')); // 350 is max
        expect(result.namespaceCount, equals(3));
        expect(result.hasHighEvictionRate, isFalse); // 125 <= 1000
      });
    });

    group('fromEntity', () {
      test('should create model from AstrocyteStats entity', () {
        // Arrange
        final entity = AstrocyteStats(
          cacheSize: 600,
          capacity: 800,
          hitRate: 80.0,
          missRate: 20.0,
          averageTTL: const Duration(milliseconds: 250000),
          namespaceDistribution: const {'test': 600},
          evictionCount: 75,
          patternMatchOperations: 300,
          timestamp: DateTime.parse('2025-11-06T10:00:00Z'),
        );

        // Act
        final result = AstrocyteStatsModel.fromEntity(entity);

        // Assert
        expect(result.cacheSize, equals(600));
        expect(result.capacity, equals(800));
        expect(result.hitRate, equals(80.0));
        expect(result.missRate, equals(20.0));
        expect(result.averageTTLMs, equals(250000));
        expect(result.namespaceDistribution, equals({'test': 600}));
        expect(result.evictionCount, equals(75));
        expect(result.patternMatchOperations, equals(300));
        expect(
          result.timestamp,
          equals(DateTime.parse('2025-11-06T10:00:00Z')),
        );
      });
    });

    group('copyWith', () {
      test('should return a new model with updated values', () {
        // Act
        final result = tAstrocyteStatsModel.copyWith(
          cacheSize: 900,
          hitRate: 90.0,
          evictionCount: 200,
        );

        // Assert
        expect(result.capacity, equals(tAstrocyteStatsModel.capacity));
        expect(result.cacheSize, equals(900));
        expect(result.hitRate, equals(90.0));
        expect(result.evictionCount, equals(200));
        expect(result.missRate, equals(tAstrocyteStatsModel.missRate));
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final model1 = AstrocyteStatsModel(
          cacheSize: 750,
          capacity: 1000,
          hitRate: 85.5,
          missRate: 14.5,
          averageTTLMs: 300000,
          namespaceDistribution: const {'users': 350},
          evictionCount: 125,
        );

        final model2 = AstrocyteStatsModel(
          cacheSize: 750,
          capacity: 1000,
          hitRate: 85.5,
          missRate: 14.5,
          averageTTLMs: 300000,
          namespaceDistribution: const {'users': 350},
          evictionCount: 125,
        );

        // Assert
        expect(model1, equals(model2));
        expect(model1.hashCode, equals(model2.hashCode));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        final model1 = tAstrocyteStatsModel;
        final model2 = tAstrocyteStatsModel.copyWith(cacheSize: 500);

        // Assert
        expect(model1, isNot(equals(model2)));
      });
    });
  });
}
