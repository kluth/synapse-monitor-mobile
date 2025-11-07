import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/alert.dart';
import '../entities/error_log.dart';
import '../entities/metric_data_point.dart';
import '../entities/neuroplasticity_event.dart';
import '../entities/system_health.dart';

/// Repository interface for system health operations.
///
/// Defines the contract for accessing system health data, error logs,
/// metrics, and neuroplasticity events from the Synapse Framework.
abstract class SystemHealthRepository {
  /// Fetch current system health status.
  ///
  /// Returns a [Right] with [SystemHealth] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, SystemHealth>> getSystemHealth();

  /// Fetch error logs with optional filtering.
  ///
  /// Parameters:
  /// - [serviceName]: Optional filter by service name
  /// - [limit]: Maximum number of logs to return (default: 50)
  ///
  /// Returns a [Right] with list of [ErrorLog] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<ErrorLog>>> getErrorLogs({
    String? serviceName,
    int limit = 50,
  });

  /// Fetch neuroplasticity events (self-healing, adaptation).
  ///
  /// Parameters:
  /// - [limit]: Maximum number of events to return (default: 50)
  ///
  /// Returns a [Right] with list of [NeuroplasticityEvent] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<NeuroplasticityEvent>>>
      getNeuroplasticityEvents({
    int limit = 50,
  });

  /// Fetch custom metrics from the system.
  ///
  /// Returns a [Right] with map of metric names to values,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, Map<String, double>>> getMetrics();

  /// Fetch time-series data for a specific metric.
  ///
  /// Parameters:
  /// - [metricName]: Name of the metric
  /// - [start]: Start of the time range
  /// - [end]: End of the time range
  ///
  /// Returns a [Right] with list of [MetricDataPoint] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<MetricDataPoint>>> getMetricTimeSeries(
    String metricName,
    DateTime start,
    DateTime end,
  );

  /// Fetch all active alerts.
  ///
  /// Returns a [Right] with list of active [Alert] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<Alert>>> getActiveAlerts();

  /// Fetch alert history.
  ///
  /// Parameters:
  /// - [limit]: Maximum number of alerts to return (default: 100)
  ///
  /// Returns a [Right] with list of [Alert] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<Alert>>> getAlertHistory({
    int limit = 100,
  });

  /// Acknowledge an alert.
  ///
  /// Parameters:
  /// - [alertId]: ID of the alert to acknowledge
  /// - [acknowledgedBy]: Name/ID of who acknowledged it
  ///
  /// Returns a [Right] with the updated [Alert] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, Alert>> acknowledgeAlert(
    String alertId,
    String acknowledgedBy,
  );

  /// Get error logs by severity.
  ///
  /// Parameters:
  /// - [severity]: Severity level to filter by
  ///
  /// Returns a [Right] with filtered list of [ErrorLog] on success,
  /// or a [Left] with [Failure] on error.
  Future<Either<Failure, List<ErrorLog>>> getErrorLogsBySeverity(
    String severity,
  );

  /// Stream real-time system health updates.
  ///
  /// Returns a stream of [SystemHealth] updates.
  Stream<SystemHealth> watchSystemHealth();

  /// Stream real-time alert notifications.
  ///
  /// Returns a stream of new [Alert] as they are created.
  Stream<Alert> watchAlerts();

  /// Stream real-time error logs.
  ///
  /// Returns a stream of new [ErrorLog] as they occur.
  Stream<ErrorLog> watchErrorLogs();

  /// Stream real-time neuroplasticity events.
  ///
  /// Returns a stream of [NeuroplasticityEvent] as they occur.
  Stream<NeuroplasticityEvent> watchNeuroplasticityEvents();
}
