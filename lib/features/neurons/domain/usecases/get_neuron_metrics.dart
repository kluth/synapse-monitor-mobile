import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../system_health/domain/entities/metric_data_point.dart';
import '../repositories/neuron_repository.dart';

/// Use case for fetching time-series metrics for a specific neuron.
///
/// Returns metric data points within the specified time range.
///
/// Example:
/// ```dart
/// final useCase = GetNeuronMetrics(repository);
/// final result = await useCase(GetNeuronMetricsParams(
///   id: 'neuron-123',
///   start: DateTime.now().subtract(Duration(hours: 24)),
///   end: DateTime.now(),
/// ));
/// ```
class GetNeuronMetrics
    implements UseCase<List<MetricDataPoint>, GetNeuronMetricsParams> {
  const GetNeuronMetrics(this._repository);

  final NeuronRepository _repository;

  @override
  Future<Either<Failure, List<MetricDataPoint>>> call(
    GetNeuronMetricsParams params,
  ) async {
    return _repository.getNeuronMetrics(params.id, params.start, params.end);
  }
}

/// Parameters for [GetNeuronMetrics] use case.
class GetNeuronMetricsParams extends Equatable {
  const GetNeuronMetricsParams({
    required this.id,
    required this.start,
    required this.end,
  });

  final String id;
  final DateTime start;
  final DateTime end;

  @override
  List<Object?> get props => [id, start, end];
}
