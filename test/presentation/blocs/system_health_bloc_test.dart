import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:synapse_monitor/core/error/failures.dart';
import 'package:synapse_monitor/domain/entities/system_health.dart';
import 'package:synapse_monitor/domain/entities/alert.dart';
import 'package:synapse_monitor/domain/entities/error_log.dart';
import 'package:synapse_monitor/domain/usecases/get_system_health.dart';
import 'package:synapse_monitor/domain/usecases/get_active_alerts.dart';
import 'package:synapse_monitor/domain/usecases/acknowledge_alert.dart';
import 'package:synapse_monitor/presentation/blocs/system_health/system_health_bloc.dart';

class MockGetSystemHealth extends Mock implements GetSystemHealth {}
class MockGetActiveAlerts extends Mock implements GetActiveAlerts {}
class MockAcknowledgeAlert extends Mock implements AcknowledgeAlert {}

/// 🔴 RED PHASE - SystemHealthBloc Tests

void main() {
  late SystemHealthBloc bloc;
  late MockGetSystemHealth mockGetSystemHealth;
  late MockGetActiveAlerts mockGetActiveAlerts;
  late MockAcknowledgeAlert mockAcknowledgeAlert;

  setUp(() {
    mockGetSystemHealth = MockGetSystemHealth();
    mockGetActiveAlerts = MockGetActiveAlerts();
    mockAcknowledgeAlert = MockAcknowledgeAlert();

    bloc = SystemHealthBloc(
      getSystemHealth: mockGetSystemHealth,
      getActiveAlerts: mockGetActiveAlerts,
      acknowledgeAlert: mockAcknowledgeAlert,
    );
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

  group('Initial State', () {
    test('should have SystemHealthInitial as initial state', () async {
      // This test will FAIL

      expect(bloc.state, SystemHealthInitial());
    });
  });

  group('LoadSystemHealth Event', () {
    blocTest<SystemHealthBloc, SystemHealthState>(
      'should emit [Loading, Loaded] when health data is fetched successfully',
      build: () {
        when(() => mockGetSystemHealth())
            .thenAnswer((_) async => Right(tSystemHealth));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadSystemHealthEvent()),
      expect: () => [
        SystemHealthLoading(),
        SystemHealthLoaded(health: tSystemHealth),
      ],
      verify: (_) {
        verify(() => mockGetSystemHealth()).called(1);
      },
    );

    blocTest<SystemHealthBloc, SystemHealthState>(
      'should emit [Loading, Error] when fetching fails',
      build: () {
        when(() => mockGetSystemHealth())
            .thenAnswer((_) async => Left(ServerFailure(statusCode: 500)));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadSystemHealthEvent()),
      expect: () => [
        SystemHealthLoading(),
        isA<SystemHealthError>(),
      ],
    );
  });

  group('LoadAlerts Event', () {
    blocTest<SystemHealthBloc, SystemHealthState>(
      'should emit [Loading, AlertsLoaded] when alerts are fetched successfully',
      build: () {
        when(() => mockGetActiveAlerts())
            .thenAnswer((_) async => Right(tAlerts));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadAlertsEvent()),
      expect: () => [
        SystemHealthLoading(),
        AlertsLoaded(alerts: tAlerts),
      ],
      verify: (_) {
        verify(() => mockGetActiveAlerts()).called(1);
      },
    );

    blocTest<SystemHealthBloc, SystemHealthState>(
      'should emit empty alerts list when no active alerts',
      build: () {
        when(() => mockGetActiveAlerts())
            .thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadAlertsEvent()),
      expect: () => [
        SystemHealthLoading(),
        const AlertsLoaded(alerts: []),
      ],
    );
  });

  group('AcknowledgeAlert Event', () {
    final acknowledgedAlert = Alert(
      id: 'alert-1',
      title: 'High CPU',
      message: 'CPU usage exceeded 90%',
      severity: AlertSeverity.warning,
      timestamp: DateTime.now(),
      acknowledged: true,
    );

    blocTest<SystemHealthBloc, SystemHealthState>(
      'should emit [ActionInProgress, AlertAcknowledged] when acknowledgment succeeds',
      build: () {
        when(() => mockAcknowledgeAlert(any()))
            .thenAnswer((_) async => Right(acknowledgedAlert));
        return bloc;
      },
      act: (bloc) => bloc.add(const AcknowledgeAlertEvent(alertId: 'alert-1')),
      expect: () => [
        SystemHealthActionInProgress(),
        AlertAcknowledged(alert: acknowledgedAlert),
      ],
      verify: (_) {
        verify(() => mockAcknowledgeAlert(
              const AcknowledgeAlertParams(alertId: 'alert-1'),
            )).called(1);
      },
    );

    blocTest<SystemHealthBloc, SystemHealthState>(
      'should emit [ActionInProgress, Error] when acknowledgment fails',
      build: () {
        when(() => mockAcknowledgeAlert(any()))
            .thenAnswer((_) async => Left(NotFoundFailure(resource: 'Alert')));
        return bloc;
      },
      act: (bloc) => bloc.add(const AcknowledgeAlertEvent(alertId: 'nonexistent')),
      expect: () => [
        SystemHealthActionInProgress(),
        isA<SystemHealthError>(),
      ],
    );
  });

  group('RefreshSystemHealth Event', () {
    blocTest<SystemHealthBloc, SystemHealthState>(
      'should periodically refresh health data',
      build: () {
        when(() => mockGetSystemHealth())
            .thenAnswer((_) async => Right(tSystemHealth));
        return bloc;
      },
      act: (bloc) => bloc.add(RefreshSystemHealthEvent()),
      expect: () => [
        SystemHealthLoaded(health: tSystemHealth),
      ],
      verify: (_) {
        verify(() => mockGetSystemHealth()).called(1);
      },
    );
  });

  group('Filter Alerts Event', () {
    blocTest<SystemHealthBloc, SystemHealthState>(
      'should filter alerts by severity',
      build: () => bloc,
      seed: () => AlertsLoaded(alerts: tAlerts),
      act: (bloc) => bloc.add(const FilterAlertsBySeverityEvent(
        severity: AlertSeverity.warning,
      )),
      expect: () => [
        AlertsLoaded(alerts: tAlerts, severityFilter: AlertSeverity.warning),
      ],
    );

    blocTest<SystemHealthBloc, SystemHealthState>(
      'should show only unacknowledged alerts',
      build: () => bloc,
      seed: () => AlertsLoaded(alerts: tAlerts),
      act: (bloc) => bloc.add(const ShowUnacknowledgedAlertsEvent()),
      expect: () => [
        AlertsLoaded(alerts: tAlerts, showOnlyUnacknowledged: true),
      ],
    );
  });
}
