import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:synapse_monitor/features/glial_cells/data/models/ependymal_stats_model.dart';
import 'package:synapse_monitor/features/glial_cells/domain/entities/ependymal_stats.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  group('RateLimitingStatsModel', () {
    final tRateLimitingStatsModel = RateLimitingStatsModel(
      activeRateLimits: 25,
      rateLimitViolations: 45,
      windowSizeMs: 60000,
      maxRequestsPerWindow: 1000,
    );

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Arrange
        final jsonMap = {
          'activeRateLimits': 25,
          'rateLimitViolations': 45,
          'windowSizeMs': 60000,
          'maxRequestsPerWindow': 1000,
        };

        // Act
        final result = RateLimitingStatsModel.fromJson(jsonMap);

        // Assert
        expect(result, equals(tRateLimitingStatsModel));
      });

      test('should handle missing optional fields', () {
        // Arrange
        final jsonMap = {
          'activeRateLimits': 25,
          'rateLimitViolations': 45,
          'windowSizeMs': 60000,
        };

        // Act
        final result = RateLimitingStatsModel.fromJson(jsonMap);

        // Assert
        expect(result.activeRateLimits, equals(25));
        expect(result.maxRequestsPerWindow, isNull);
      });
    });

    group('toEntity', () {
      test('should convert model to RateLimitingStats entity', () {
        // Act
        final result = tRateLimitingStatsModel.toEntity();

        // Assert
        expect(result, isA<RateLimitingStats>());
        expect(result.activeRateLimits, equals(25));
        expect(result.rateLimitViolations, equals(45));
        expect(result.windowSize, equals(const Duration(milliseconds: 60000)));
        expect(result.maxRequestsPerWindow, equals(1000));
      });

      test('should preserve entity computed properties', () {
        // Act
        final result = tRateLimitingStatsModel.toEntity();

        // Assert
        expect(result.hasFrequentViolations, isFalse); // 45 <= 100
      });
    });

    group('fromEntity', () {
      test('should create model from RateLimitingStats entity', () {
        // Arrange
        final entity = RateLimitingStats(
          activeRateLimits: 30,
          rateLimitViolations: 150,
          windowSize: const Duration(seconds: 30),
          maxRequestsPerWindow: 500,
        );

        // Act
        final result = RateLimitingStatsModel.fromEntity(entity);

        // Assert
        expect(result.activeRateLimits, equals(30));
        expect(result.rateLimitViolations, equals(150));
        expect(result.windowSizeMs, equals(30000));
        expect(result.maxRequestsPerWindow, equals(500));
      });
    });
  });

  group('EpendymalStatsModel', () {
    final tRateLimiting = RateLimitingStatsModel(
      activeRateLimits: 25,
      rateLimitViolations: 45,
      windowSizeMs: 60000,
      maxRequestsPerWindow: 1000,
    );

    final tEpendymalStatsModel = EpendymalStatsModel(
      totalRequests: 50000,
      requestRate: 850.5,
      rateLimiting: tRateLimiting,
      routeDistribution: const {
        '/api/users': 15000,
        '/api/products': 20000,
        '/api/orders': 15000,
      },
      middlewareLatencyMs: 35,
      errorResponses: const {
        '400': 150,
        '404': 200,
        '500': 50,
      },
      successRate: 99.2,
      averageResponseTimeMs: 125,
      timestamp: DateTime.parse('2025-11-07T12:00:00Z'),
    );

    group('fromJson', () {
      test('should return a valid model from JSON', () {
        // Arrange
        final jsonMap = json.decode(fixture('ependymal_stats.json'))
            as Map<String, dynamic>;

        // Act
        final result = EpendymalStatsModel.fromJson(jsonMap);

        // Assert
        expect(result, equals(tEpendymalStatsModel));
      });

      test('should handle missing optional fields', () {
        // Arrange
        final jsonMap = {
          'totalRequests': 50000,
          'requestRate': 850.5,
          'rateLimiting': {
            'activeRateLimits': 25,
            'rateLimitViolations': 45,
            'windowSizeMs': 60000,
          },
          'routeDistribution': {'/api/test': 50000},
          'middlewareLatencyMs': 35,
          'errorResponses': {'500': 10},
        };

        // Act
        final result = EpendymalStatsModel.fromJson(jsonMap);

        // Assert
        expect(result.totalRequests, equals(50000));
        expect(result.successRate, isNull);
        expect(result.averageResponseTimeMs, isNull);
        expect(result.timestamp, isNull);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () {
        // Act
        final result = tEpendymalStatsModel.toJson();

        // Assert
        expect(result['totalRequests'], equals(50000));
        expect(result['requestRate'], equals(850.5));
        expect(result['middlewareLatencyMs'], equals(35));
        expect(result['successRate'], equals(99.2));
        expect(result['averageResponseTimeMs'], equals(125));
        expect(result['timestamp'], equals('2025-11-07T12:00:00.000Z'));
        expect(result['rateLimiting'], isA<Map>());
        expect(result['routeDistribution'], isA<Map>());
        expect(result['errorResponses'], isA<Map>());
      });

      test('should properly serialize nested rate limiting model', () {
        // Act
        final result = tEpendymalStatsModel.toJson();

        // Assert
        final rateLimiting = result['rateLimiting'] as Map;
        expect(rateLimiting['activeRateLimits'], equals(25));
        expect(rateLimiting['rateLimitViolations'], equals(45));
        expect(rateLimiting['windowSizeMs'], equals(60000));
        expect(rateLimiting['maxRequestsPerWindow'], equals(1000));
      });
    });

    group('toEntity', () {
      test('should convert model to EpendymalStats entity', () {
        // Act
        final result = tEpendymalStatsModel.toEntity();

        // Assert
        expect(result, isA<EpendymalStats>());
        expect(result.totalRequests, equals(50000));
        expect(result.requestRate, equals(850.5));
        expect(result.routeDistribution, equals({
          '/api/users': 15000,
          '/api/products': 20000,
          '/api/orders': 15000,
        }));
        expect(
          result.middlewareLatency,
          equals(const Duration(milliseconds: 35)),
        );
        expect(result.errorResponses, equals({
          '400': 150,
          '404': 200,
          '500': 50,
        }));
        expect(result.successRate, equals(99.2));
        expect(
          result.averageResponseTime,
          equals(const Duration(milliseconds: 125)),
        );
        expect(
          result.timestamp,
          equals(DateTime.parse('2025-11-07T12:00:00Z')),
        );
      });

      test('should properly convert nested rate limiting model', () {
        // Act
        final result = tEpendymalStatsModel.toEntity();

        // Assert
        expect(result.rateLimiting.activeRateLimits, equals(25));
        expect(result.rateLimiting.rateLimitViolations, equals(45));
        expect(
          result.rateLimiting.windowSize,
          equals(const Duration(milliseconds: 60000)),
        );
        expect(result.rateLimiting.maxRequestsPerWindow, equals(1000));
      });

      test('should preserve entity computed properties', () {
        // Act
        final result = tEpendymalStatsModel.toEntity();

        // Assert
        // totalErrors = 150 + 200 + 50 = 400
        expect(result.totalErrors, equals(400));
        // errorRatePercentage = (400 / 50000) * 100 = 0.8%
        expect(result.errorRatePercentage, equals(0.8));
        expect(result.calculatedSuccessRate, equals(99.2));
        expect(result.hasHealthySuccessRate, isTrue); // 99.2% > 95%
        expect(result.hasHighErrorRate, isFalse); // 0.8% <= 5%
        expect(result.hasHighRequestRate, isFalse); // 850.5 <= 1000
        expect(result.hasAcceptableMiddlewareLatency, isTrue); // 35ms < 50ms
        expect(result.mostAccessedRoute, equals('/api/products')); // 20000 is max
        expect(result.clientErrorCount, equals(350)); // 400 + 404
        expect(result.serverErrorCount, equals(50)); // 500
      });
    });

    group('fromEntity', () {
      test('should create model from EpendymalStats entity', () {
        // Arrange
        final entity = EpendymalStats(
          totalRequests: 30000,
          requestRate: 500.0,
          rateLimiting: RateLimitingStats(
            activeRateLimits: 15,
            rateLimitViolations: 25,
            windowSize: const Duration(seconds: 60),
            maxRequestsPerWindow: 600,
          ),
          routeDistribution: const {'/api/test': 30000},
          middlewareLatency: const Duration(milliseconds: 40),
          errorResponses: const {'500': 100},
          successRate: 98.0,
          averageResponseTime: const Duration(milliseconds: 100),
          timestamp: DateTime.parse('2025-11-06T10:00:00Z'),
        );

        // Act
        final result = EpendymalStatsModel.fromEntity(entity);

        // Assert
        expect(result.totalRequests, equals(30000));
        expect(result.requestRate, equals(500.0));
        expect(result.middlewareLatencyMs, equals(40));
        expect(result.successRate, equals(98.0));
        expect(result.averageResponseTimeMs, equals(100));
        expect(
          result.timestamp,
          equals(DateTime.parse('2025-11-06T10:00:00Z')),
        );
      });
    });

    group('copyWith', () {
      test('should return a new model with updated values', () {
        // Act
        final result = tEpendymalStatsModel.copyWith(
          totalRequests: 60000,
          requestRate: 1000.0,
          successRate: 99.5,
        );

        // Assert
        expect(
          result.middlewareLatencyMs,
          equals(tEpendymalStatsModel.middlewareLatencyMs),
        );
        expect(result.totalRequests, equals(60000));
        expect(result.requestRate, equals(1000.0));
        expect(result.successRate, equals(99.5));
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final rateLimiting1 = RateLimitingStatsModel(
          activeRateLimits: 25,
          rateLimitViolations: 45,
          windowSizeMs: 60000,
        );

        final model1 = EpendymalStatsModel(
          totalRequests: 50000,
          requestRate: 850.5,
          rateLimiting: rateLimiting1,
          routeDistribution: const {'/api/test': 50000},
          middlewareLatencyMs: 35,
          errorResponses: const {'500': 50},
        );

        final rateLimiting2 = RateLimitingStatsModel(
          activeRateLimits: 25,
          rateLimitViolations: 45,
          windowSizeMs: 60000,
        );

        final model2 = EpendymalStatsModel(
          totalRequests: 50000,
          requestRate: 850.5,
          rateLimiting: rateLimiting2,
          routeDistribution: const {'/api/test': 50000},
          middlewareLatencyMs: 35,
          errorResponses: const {'500': 50},
        );

        // Assert
        expect(model1, equals(model2));
        expect(model1.hashCode, equals(model2.hashCode));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        final model1 = tEpendymalStatsModel;
        final model2 = tEpendymalStatsModel.copyWith(totalRequests: 100000);

        // Assert
        expect(model1, isNot(equals(model2)));
      });
    });
  });
}
