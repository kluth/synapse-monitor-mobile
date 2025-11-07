import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/error_log.dart';

part 'error_log_model.freezed.dart';
part 'error_log_model.g.dart';

/// Data model for [ErrorLog] with JSON serialization support.
@freezed
class ErrorLogModel with _$ErrorLogModel {
  const factory ErrorLogModel({
    required String id,
    required String serviceName,
    required String error,
    required DateTime timestamp,
    String? stackTrace,
    Map<String, dynamic>? context,
    String? severity,
    bool? resolved,
    DateTime? resolvedAt,
  }) = _ErrorLogModel;

  const ErrorLogModel._();

  factory ErrorLogModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorLogModelFromJson(json);

  ErrorLog toEntity() {
    return ErrorLog(
      id: id,
      serviceName: serviceName,
      error: error,
      timestamp: timestamp,
      stackTrace: stackTrace,
      context: context,
      severity: severity,
      resolved: resolved,
      resolvedAt: resolvedAt,
    );
  }

  factory ErrorLogModel.fromEntity(ErrorLog entity) {
    return ErrorLogModel(
      id: entity.id,
      serviceName: entity.serviceName,
      error: entity.error,
      timestamp: entity.timestamp,
      stackTrace: entity.stackTrace,
      context: entity.context,
      severity: entity.severity,
      resolved: entity.resolved,
      resolvedAt: entity.resolvedAt,
    );
  }
}
