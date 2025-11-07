import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failures.dart';

/// Base class for all use cases in the application.
///
/// Use cases encapsulate business logic and are the entry point to the domain layer.
/// They follow the Single Responsibility Principle - each use case does one thing.
///
/// Type parameters:
/// - [Type]: The type of data returned on success
/// - [Params]: The parameters required to execute the use case
///
/// Returns:
/// - [Either<Failure, Type>]: A result that can be either a [Failure] or the expected [Type]
abstract class UseCase<Type, Params> {
  /// Execute the use case
  Future<Either<Failure, Type>> call(Params params);
}

/// Use case that doesn't require any parameters.
///
/// Example:
/// ```dart
/// class GetSystemHealth implements UseCase<SystemHealth, NoParams> {
///   @override
///   Future<Either<Failure, SystemHealth>> call(NoParams params) async {
///     // Implementation
///   }
/// }
/// ```
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Base class for use cases that work with streams.
///
/// Type parameters:
/// - [Type]: The type of data emitted by the stream
/// - [Params]: The parameters required to create the stream
abstract class StreamUseCase<Type, Params> {
  /// Execute the use case and return a stream
  Stream<Type> call(Params params);
}
