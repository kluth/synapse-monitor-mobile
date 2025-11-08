import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:synapse_monitor/core/error/failures.dart';
import 'package:synapse_monitor/domain/entities/system_health.dart';
import 'package:synapse_monitor/domain/entities/alert.dart';
import 'package:synapse_monitor/domain/entities/error_log.dart';
import 'package:synapse_monitor/domain/entities/metric_history.dart';
import 'package:synapse_monitor/domain/repositories/system_health_repository.dart';
import 'package:synapse_monitor/domain/usecases/get_system_health.dart';
import 'package:synapse_monitor/domain/usecases/get_active_alerts.dart';
import 'package:synapse_monitor/domain/usecases/get_error_logs.dart';
import 'package:synapse_monitor/domain/usecases/get_metric_history.dart';
import 'package:synapse_monitor/domain/usecases/acknowledge_alert.dart';
import 'package:synapse_monitor/domain/usecases/get_neuroplasticity_events.dart';

class MockSystemHealthRepository extends Mock implements SystemHealthRepository {}

/// 🔴 RED PHASE - System Health Use Cases Tests (6 use cases)

void main() {
  late MockSystemHealthRepository mockRepository;

  setUp(() {
    mockRepository = MockSystemHealthRepository();
  });

  group('GetSystemHealth', () {
    late GetSystemHealth usecase;

    setUp(() {
      usecase = GetSystemHealth(mockRepository);
    });

    final tSystemHealth = SystemHealth(
      cpuUsage: 45.5,
      memoryUsage: 60.0,
      activeConnections: 120,
      requestsPerSecond: 350.0,
      errorRate: 0.02,
      uptime: 86400,
      timestamp: DateTime.now(),
    );

    test('should get system health from repository', () async {
      // This test will FAIL

      when(() => mockRepository.getSystemHealth())
          .thenAnswer((_) async => Right(tSystemHealth));

      final result = await usecase();

      expect(result, Right(tSystemHealth));
      verify(() => mockRepository.getSystemHealth()).called(1);
    });

    test('should return ServerFailure when server error occurs', () async {
      // This test will FAIL

      when(() => mockRepository.getSystemHealth())
          .thenAnswer((_) async => Left(ServerFailure(statusCode: 500)));

      final result = await usecase();

      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Should return Left'),
      );
    });
  });

  group('GetActiveAlerts', () {
    late GetActiveAlerts usecase;

    setUp(() {
      usecase = GetActiveAlerts(mockRepository);
    });

    final tAlerts = [
      Alert(
        id: 'alert-1',
        title: 'High CPU',
        message: 'CPU usage exceeded 90%',
        severity: AlertSeverity.warning,
        timestamp: DateTime.now(),
        acknowledged: false,
      ),
    ];

    test('should get active alerts from repository', () async {
      // This test will FAIL

      when(() => mockRepository.getActiveAlerts())
          .thenAnswer((_) async => Right(tAlerts));

      final result = await usecase();

      expect(result, Right(tAlerts));
      verify(() => mockRepository.getActiveAlerts()).called(1);
    });

    test('should return empty list when no active alerts', () async {
      // This test will FAIL

      when(() => mockRepository.getActiveAlerts())
          .thenAnswer((_) async => const Right([]));

      final result = await usecase();

      result.fold(
        (_) => fail('Should return Right'),
        (alerts) => expect(alerts, isEmpty),
      );
    });
  });

  group('GetErrorLogs', () {
    late GetErrorLogs usecase;

    setUp(() {
      usecase = GetErrorLogs(mockRepository);
    });

    final tErrorLogs = [
      ErrorLog(
        id: 'error-1',
        message: 'Connection timeout',
        errorCode: 'CONN_TIMEOUT',
        severity: ErrorSeverity.error,
        timestamp: DateTime.now(),
      ),
    ];

    test('should get error logs from repository', () async {
      // This test will FAIL

      when(() => mockRepository.getErrorLogs(limit: 50))
          .thenAnswer((_) async => Right(tErrorLogs));

      final result = await usecase(const GetErrorLogsParams(limit: 50));

      expect(result, Right(tErrorLogs));
      verify(() => mockRepository.getErrorLogs(limit: 50)).called(1);
    });

    test('should use default limit when not specified', () async {
      // This test will FAIL

      when(() => mockRepository.getErrorLogs(limit: 100))
          .thenAnswer((_) async => Right(tErrorLogs));

      final result = await usecase(const GetErrorLogsParams());

      verify(() => mockRepository.getErrorLogs(limit: 100)).called(1);
    });
  });

  group('GetMetricHistory', () {
    late GetMetricHistory usecase;

    setUp(() {
      usecase = GetMetricHistory(mockRepository);
    });

    final tMetricHistory = MetricHistory(
      metricName: 'cpu_usage',
      dataPoints: [
        DataPoint(timestamp: DateTime.now(), value: 45.0),
      ],
      unit: '%',
    );

    test('should get metric history from repository', () async {
      // This test will FAIL

      when(() => mockRepository.getMetricHistory(
            metricName: 'cpu_usage',
            timeRange: const Duration(hours: 24),
          ))
          .thenAnswer((_) async => Right(tMetricHistory));

      final result = await usecase(const GetMetricHistoryParams(
        metricName: 'cpu_usage',
        timeRange: Duration(hours: 24),
      ));

      expect(result, Right(tMetricHistory));
      verify(() => mockRepository.getMetricHistory(
            metricName: 'cpu_usage',
            timeRange: const Duration(hours: 24),
          )).called(1);
    });

    test('should return NotFoundFailure when metric does not exist', () async {
      // This test will FAIL

      when(() => mockRepository.getMetricHistory(
            metricName: 'invalid_metric',
            timeRange: const Duration(hours: 24),
          ))
          .thenAnswer((_) async => Left(NotFoundFailure(resource: 'Metric')));

      final result = await usecase(const GetMetricHistoryParams(
        metricName: 'invalid_metric',
        timeRange: Duration(hours: 24),
      ));

      result.fold(
        (failure) => expect(failure, isA<NotFoundFailure>()),
        (_) => fail('Should return Left'),
      );
    });
  });

  group('AcknowledgeAlert', () {
    late AcknowledgeAlert usecase;

    setUp(() {
      usecase = AcknowledgeAlert(mockRepository);
    });

    final tAlert = Alert(
      id: 'alert-1',
      title: 'High CPU',
      message: 'CPU usage exceeded 90%',
      severity: AlertSeverity.warning,
      timestamp: DateTime.now(),
      acknowledged: true,
    );

    test('should acknowledge alert via repository', () async {
      // This test will FAIL

      when(() => mockRepository.acknowledgeAlert('alert-1'))
          .thenAnswer((_) async => Right(tAlert));

      final result = await usecase(const AcknowledgeAlertParams(alertId: 'alert-1'));

      expect(result, Right(tAlert));
      verify(() => mockRepository.acknowledgeAlert('alert-1')).called(1);
    });

    test('should return NotFoundFailure when alert does not exist', () async {
      // This test will FAIL

      when(() => mockRepository.acknowledgeAlert('nonexistent'))
          .thenAnswer((_) async => Left(NotFoundFailure(resource: 'Alert')));

      final result = await usecase(const AcknowledgeAlertParams(alertId: 'nonexistent'));

      result.fold(
        (failure) => expect(failure, isA<NotFoundFailure>()),
        (_) => fail('Should return Left'),
      );
    });
  });

  group('GetNeuroplasticityEvents', () {
    late GetNeuroplasticityEvents usecase;

    setUp(() {
      usecase = GetNeuroplasticityEvents(mockRepository);
    });

    final tEvents = [
      NeuroplasticityEvent(
        id: 'event-1',
        type: 'synapse_strengthened',
        description: 'Synapse weight increased from 0.5 to 0.8',
        timestamp: DateTime.now(),
      ),
    ];

    test('should get neuroplasticity events from repository', () async {
      // This test will FAIL

      when(() => mockRepository.getNeuroplasticityEvents(limit: 20))
          .thenAnswer((_) async => Right(tEvents));

      final result = await usecase(const GetNeuroplasticityEventsParams(limit: 20));

      expect(result, Right(tEvents));
      verify(() => mockRepository.getNeuroplasticityEvents(limit: 20)).called(1);
    });
  });
}
