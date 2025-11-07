import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/features/glial_cells/data/models/oligodendrocyte_stats_model.dart';
import 'package:synapse_monitor/features/glial_cells/domain/entities/oligodendrocyte_stats.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  group('OligodendrocyteStatsModel', () {
    final tOligodendrocyteStatsModel = OligodendrocyteStatsModel(
      connectionPoolSize: 45,
      maxConnectionPoolSize: 100,
      resourceCacheHits: 8500,
      resourceCacheMisses: 1500,
      memoizationHits: 350,
      myelinatedPathsCount: 75,
      poolExhaustionEvents: 3,
      averageConnectionAcquisitionTimeMs: 25,
      timestamp: DateTime.parse('2025-11-07T12:00:00Z'),
    );

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Arrange
        final jsonMap = json.decode(fixture('oligodendrocyte_stats.json'))
            as Map<String, dynamic>;

        // Act
        final result = OligodendrocyteStatsModel.fromJson(jsonMap);

        // Assert
        expect(result, equals(tOligodendrocyteStatsModel));
      });

      test('should handle missing optional fields', () {
        // Arrange
        final jsonMap = {
          'connectionPoolSize': 45,
          'maxConnectionPoolSize': 100,
          'resourceCacheHits': 8500,
          'resourceCacheMisses': 1500,
          'memoizationHits': 350,
          'myelinatedPathsCount': 75,
          'poolExhaustionEvents': 3,
        };

        // Act
        final result = OligodendrocyteStatsModel.fromJson(jsonMap);

        // Assert
        expect(result.connectionPoolSize, equals(45));
        expect(result.averageConnectionAcquisitionTimeMs, isNull);
        expect(result.timestamp, isNull);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // Act
        final result = tOligodendrocyteStatsModel.toJson();

        // Assert
        final expectedMap = {
          'connectionPoolSize': 45,
          'maxConnectionPoolSize': 100,
          'resourceCacheHits': 8500,
          'resourceCacheMisses': 1500,
          'memoizationHits': 350,
          'myelinatedPathsCount': 75,
          'poolExhaustionEvents': 3,
          'averageConnectionAcquisitionTimeMs': 25,
          'timestamp': '2025-11-07T12:00:00.000Z',
        };

        expect(result, equals(expectedMap));
      });
    });

    group('toEntity', () {
      test('should convert model to OligodendrocyteStats entity', () {
        // Act
        final result = tOligodendrocyteStatsModel.toEntity();

        // Assert
        expect(result, isA<OligodendrocyteStats>());
        expect(result.connectionPoolSize, equals(45));
        expect(result.maxConnectionPoolSize, equals(100));
        expect(result.resourceCacheHits, equals(8500));
        expect(result.resourceCacheMisses, equals(1500));
        expect(result.memoizationHits, equals(350));
        expect(result.myelinatedPathsCount, equals(75));
        expect(result.poolExhaustionEvents, equals(3));
        expect(
          result.averageConnectionAcquisitionTime,
          equals(const Duration(milliseconds: 25)),
        );
        expect(
          result.timestamp,
          equals(DateTime.parse('2025-11-07T12:00:00Z')),
        );
      });

      test('should preserve entity computed properties', () {
        // Act
        final result = tOligodendrocyteStatsModel.toEntity();

        // Assert
        // poolUtilizationPercentage = (45 / 100) * 100 = 45.0%
        expect(result.poolUtilizationPercentage, equals(45.0));
        expect(result.isPoolNearlyExhausted, isFalse); // 45% <= 80%
        expect(result.isPoolExhausted, isFalse); // 45 < 100
        // resourceCacheHitRate = (8500 / 10000) * 100 = 85.0%
        expect(result.resourceCacheHitRate, equals(85.0));
        expect(result.hasHealthyCachePerformance, isTrue); // 85% > 70%
        expect(result.hasFrequentExhaustion, isFalse); // 3 <= 10
        expect(result.hasEffectiveMemoization, isTrue); // 350 > 100
        expect(result.totalCacheOperations, equals(10000));
      });
    });

    group('fromEntity', () {
      test('should create model from OligodendrocyteStats entity', () {
        // Arrange
        final entity = OligodendrocyteStats(
          connectionPoolSize: 60,
          maxConnectionPoolSize: 80,
          resourceCacheHits: 5000,
          resourceCacheMisses: 500,
          memoizationHits: 200,
          myelinatedPathsCount: 50,
          poolExhaustionEvents: 5,
          averageConnectionAcquisitionTime: const Duration(milliseconds: 30),
          timestamp: DateTime.parse('2025-11-06T10:00:00Z'),
        );

        // Act
        final result = OligodendrocyteStatsModel.fromEntity(entity);

        // Assert
        expect(result.connectionPoolSize, equals(60));
        expect(result.maxConnectionPoolSize, equals(80));
        expect(result.resourceCacheHits, equals(5000));
        expect(result.resourceCacheMisses, equals(500));
        expect(result.memoizationHits, equals(200));
        expect(result.myelinatedPathsCount, equals(50));
        expect(result.poolExhaustionEvents, equals(5));
        expect(result.averageConnectionAcquisitionTimeMs, equals(30));
        expect(
          result.timestamp,
          equals(DateTime.parse('2025-11-06T10:00:00Z')),
        );
      });
    });

    group('copyWith', () {
      test('should return a new model with updated values', () {
        // Act
        final result = tOligodendrocyteStatsModel.copyWith(
          connectionPoolSize: 90,
          resourceCacheHits: 10000,
          poolExhaustionEvents: 8,
        );

        // Assert
        expect(
          result.maxConnectionPoolSize,
          equals(tOligodendrocyteStatsModel.maxConnectionPoolSize),
        );
        expect(result.connectionPoolSize, equals(90));
        expect(result.resourceCacheHits, equals(10000));
        expect(result.poolExhaustionEvents, equals(8));
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final model1 = OligodendrocyteStatsModel(
          connectionPoolSize: 45,
          maxConnectionPoolSize: 100,
          resourceCacheHits: 8500,
          resourceCacheMisses: 1500,
          memoizationHits: 350,
          myelinatedPathsCount: 75,
          poolExhaustionEvents: 3,
        );

        final model2 = OligodendrocyteStatsModel(
          connectionPoolSize: 45,
          maxConnectionPoolSize: 100,
          resourceCacheHits: 8500,
          resourceCacheMisses: 1500,
          memoizationHits: 350,
          myelinatedPathsCount: 75,
          poolExhaustionEvents: 3,
        );

        // Assert
        expect(model1, equals(model2));
        expect(model1.hashCode, equals(model2.hashCode));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        final model1 = tOligodendrocyteStatsModel;
        final model2 = tOligodendrocyteStatsModel.copyWith(connectionPoolSize: 80);

        // Assert
        expect(model1, isNot(equals(model2)));
      });
    });
  });
}
