import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'core/network/dio_client.dart';
import 'core/network/network_info.dart';
import 'core/network/websocket_client.dart';
import 'core/utils/logger.dart';

/// Global service locator instance
final getIt = GetIt.instance;

/// Initialize dependency injection.
///
/// Call this once at app startup before runApp().
/// Register all dependencies here.
@InjectableInit()
Future<void> configureDependencies() async {
  // ============================================================================
  // CORE - Utilities
  // ============================================================================

  // Logger
  getIt.registerLazySingleton<AppLogger>(() => AppLogger());

  // ============================================================================
  // CORE - Network
  // ============================================================================

  // Dio instance
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Dio Client (HTTP)
  getIt.registerLazySingleton<DioClient>(
    () => DioClient(
      dio: getIt<Dio>(),
      logger: getIt<AppLogger>(),
    ),
  );

  // WebSocket Client
  getIt.registerLazySingleton<WebSocketClient>(
    () => WebSocketClient(
      logger: getIt<AppLogger>(),
    ),
  );

  // Network Info
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(),
  );

  // ============================================================================
  // DATA SOURCES
  // ============================================================================

  // TODO: Register data sources here when implemented
  // Example:
  // getIt.registerLazySingleton<NeuronRemoteDataSource>(
  //   () => NeuronRemoteDataSourceImpl(
  //     dioClient: getIt<DioClient>(),
  //   ),
  // );

  // ============================================================================
  // REPOSITORIES
  // ============================================================================

  // TODO: Register repositories here when implemented
  // Example:
  // getIt.registerLazySingleton<NeuronRepository>(
  //   () => NeuronRepositoryImpl(
  //     remoteDataSource: getIt<NeuronRemoteDataSource>(),
  //     networkInfo: getIt<NetworkInfo>(),
  //   ),
  // );

  // ============================================================================
  // USE CASES
  // ============================================================================

  // TODO: Register use cases here when implemented
  // Example:
  // getIt.registerLazySingleton<GetNeurons>(
  //   () => GetNeurons(getIt<NeuronRepository>()),
  // );
}

/// Reset all dependencies (useful for testing)
Future<void> resetDependencies() async {
  await getIt.reset();
}
