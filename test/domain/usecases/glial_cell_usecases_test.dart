import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:synapse_monitor/core/error/failures.dart';
import 'package:synapse_monitor/domain/entities/glial_cell.dart';
import 'package:synapse_monitor/domain/repositories/glial_cell_repository.dart';
import 'package:synapse_monitor/domain/usecases/get_astrocyte_stats.dart';
import 'package:synapse_monitor/domain/usecases/get_oligodendrocyte_stats.dart';
import 'package:synapse_monitor/domain/usecases/get_microglia_metrics.dart';
import 'package:synapse_monitor/domain/usecases/get_ependymal_stats.dart';
import 'package:synapse_monitor/domain/usecases/clear_astrocyte_cache.dart';

class MockGlialCellRepository extends Mock implements GlialCellRepository {}

/// 🔴 RED PHASE - Glial Cell Use Cases Tests (5 use cases)

void main() {
  late MockGlialCellRepository mockRepository;

  setUp(() {
    mockRepository = MockGlialCellRepository();
  });

  group('GetAstrocyteStats', () {
    late GetAstrocyteStats usecase;

    setUp(() {
      usecase = GetAstrocyteStats(mockRepository);
    });

    final tAstrocyte = Astrocyte(
      cacheHitRate: 0.85,
      totalCacheCalls: 1000,
      averageResponseTime: 15.5,
    );

    test('should get astrocyte stats from repository', () async {
      // This test will FAIL

      when(() => mockRepository.getAstrocyteStats())
          .thenAnswer((_) async => Right(tAstrocyte));

      final result = await usecase();

      expect(result, Right(tAstrocyte));
      verify(() => mockRepository.getAstrocyteStats()).called(1);
    });

    test('should return CacheFailure when cache stats unavailable', () async {
      // This test will FAIL

      when(() => mockRepository.getAstrocyteStats())
          .thenAnswer((_) async => Left(CacheFailure()));

      final result = await usecase();

      expect(result, Left(CacheFailure()));
    });
  });

  group('GetOligodendrocyteStats', () {
    late GetOligodendrocyteStats usecase;

    setUp(() {
      usecase = GetOligodendrocyteStats(mockRepository);
    });

    final tOligodendrocyte = Oligodendrocyte(
      myelinationEfficiency: 0.92,
      myelinatedAxons: 150,
      transmissionSpeedBoost: 2.5,
    );

    test('should get oligodendrocyte stats from repository', () async {
      // This test will FAIL

      when(() => mockRepository.getOligodendrocyteStats())
          .thenAnswer((_) async => Right(tOligodendrocyte));

      final result = await usecase();

      expect(result, Right(tOligodendrocyte));
      verify(() => mockRepository.getOligodendrocyteStats()).called(1);
    });

    test('should return NetworkFailure when connection fails', () async {
      // This test will FAIL

      when(() => mockRepository.getOligodendrocyteStats())
          .thenAnswer((_) async => Left(NetworkFailure()));

      final result = await usecase();

      expect(result, Left(NetworkFailure()));
    });
  });

  group('GetMicrogliaMetrics', () {
    late GetMicrogliaMetrics usecase;

    setUp(() {
      usecase = GetMicrogliaMetrics(mockRepository);
    });

    final tMicroglia = Microglia(
      threatsDetected: 5,
      threatsNeutralized: 4,
      patrolCoverage: 0.75,
    );

    test('should get microglia metrics from repository', () async {
      // This test will FAIL

      when(() => mockRepository.getMicrogliaMetrics())
          .thenAnswer((_) async => Right(tMicroglia));

      final result = await usecase();

      expect(result, Right(tMicroglia));
      verify(() => mockRepository.getMicrogliaMetrics()).called(1);
    });

    test('should return ServerFailure when server error occurs', () async {
      // This test will FAIL

      when(() => mockRepository.getMicrogliaMetrics())
          .thenAnswer((_) async => Left(ServerFailure(statusCode: 503)));

      final result = await usecase();

      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Should return Left'),
      );
    });
  });

  group('GetEpendymalStats', () {
    late GetEpendymalStats usecase;

    setUp(() {
      usecase = GetEpendymalStats(mockRepository);
    });

    final tEpendymal = Ependymal(
      fluidFlowRate: 125.5,
      barrierIntegrity: 0.98,
      nutrientDistribution: 0.88,
    );

    test('should get ependymal stats from repository', () async {
      // This test will FAIL

      when(() => mockRepository.getEpendymalStats())
          .thenAnswer((_) async => Right(tEpendymal));

      final result = await usecase();

      expect(result, Right(tEpendymal));
      verify(() => mockRepository.getEpendymalStats()).called(1);
    });

    test('should return NetworkFailure when connection fails', () async {
      // This test will FAIL

      when(() => mockRepository.getEpendymalStats())
          .thenAnswer((_) async => Left(NetworkFailure()));

      final result = await usecase();

      expect(result, Left(NetworkFailure()));
    });
  });

  group('ClearAstrocyteCache', () {
    late ClearAstrocyteCache usecase;

    setUp(() {
      usecase = ClearAstrocyteCache(mockRepository);
    });

    test('should clear astrocyte cache via repository', () async {
      // This test will FAIL

      when(() => mockRepository.clearAstrocyteCache())
          .thenAnswer((_) async => const Right(true));

      final result = await usecase();

      expect(result, const Right(true));
      verify(() => mockRepository.clearAstrocyteCache()).called(1);
    });

    test('should return CacheFailure when cache clear fails', () async {
      // This test will FAIL

      when(() => mockRepository.clearAstrocyteCache())
          .thenAnswer((_) async => Left(CacheFailure()));

      final result = await usecase();

      expect(result, Left(CacheFailure()));
    });
  });
}
