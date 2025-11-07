import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../constants/api_constants.dart';
import '../errors/exceptions.dart';
import '../utils/logger.dart';

/// HTTP client wrapper around Dio with custom configuration and interceptors.
///
/// Provides:
/// - Automatic base URL configuration from environment
/// - Request/response logging
/// - Error transformation to custom exceptions
/// - Retry logic with exponential backoff
/// - Authentication token injection
class DioClient {
  DioClient({
    Dio? dio,
    AppLogger? logger,
  })  : _dio = dio ?? Dio(),
        _logger = logger ?? AppLogger() {
    _configureDio();
  }

  final Dio _dio;
  final AppLogger _logger;

  /// Get the configured Dio instance
  Dio get dio => _dio;

  void _configureDio() {
    // Base configuration
    _dio.options = BaseOptions(
      baseUrl: dotenv.env['SYNAPSE_REST_API'] ??
          ApiConstants.defaultRestApiBaseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      sendTimeout: ApiConstants.sendTimeout,
      headers: {
        ApiConstants.headerContentType: ApiConstants.contentTypeJson,
        ApiConstants.headerAccept: ApiConstants.contentTypeJson,
      },
    );

    // Add interceptors
    _dio.interceptors.addAll([
      _LoggingInterceptor(_logger),
      _AuthInterceptor(),
      _ErrorInterceptor(),
      _RetryInterceptor(_dio),
    ]);
  }

  /// Perform GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Perform POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Perform PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Perform DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Transform DioException to custom exceptions
  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        return const NetworkException();

      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode);

      case DioExceptionType.cancel:
        return const UnknownException('Request cancelled');

      case DioExceptionType.badCertificate:
        return const NetworkException('SSL certificate verification failed');

      case DioExceptionType.unknown:
      default:
        if (error.error is SocketException) {
          return const NetworkException();
        }
        return UnknownException(error.message ?? 'Unknown error occurred');
    }
  }

  /// Handle HTTP status codes
  Exception _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return const BadRequestException();
      case 401:
        return const UnauthorizedException();
      case 403:
        return const ForbiddenException();
      case 404:
        return const NotFoundException();
      case 500:
      case 502:
      case 503:
      case 504:
        return const ServerException();
      default:
        return ServerException('Server error: $statusCode');
    }
  }
}

/// Logging interceptor for debugging
class _LoggingInterceptor extends Interceptor {
  _LoggingInterceptor(this._logger);

  final AppLogger _logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.debug(
      'REQUEST[${options.method}] => PATH: ${options.path}',
    );
    _logger.debug('Headers: ${options.headers}');
    if (options.data != null) {
      _logger.debug('Data: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.debug(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    _logger.debug('Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.error(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    _logger.error('Error: ${err.message}');
    super.onError(err, handler);
  }
}

/// Authentication interceptor to inject tokens
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Get API key from environment
    final apiKey = dotenv.env['API_KEY'];
    if (apiKey != null && apiKey.isNotEmpty) {
      options.headers[ApiConstants.headerApiKey] = apiKey;
    }

    // TODO: Add auth token from secure storage when authentication is implemented
    // final token = await _getAuthToken();
    // if (token != null) {
    //   options.headers[ApiConstants.headerAuthorization] = 'Bearer $token';
    // }

    super.onRequest(options, handler);
  }
}

/// Error transformation interceptor
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Transform error response data if needed
    if (err.response?.data is Map<String, dynamic>) {
      final data = err.response?.data as Map<String, dynamic>;
      if (data.containsKey('message')) {
        // Create a new error with the server message
        final newErr = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: data['message'],
        );
        return handler.next(newErr);
      }
    }
    super.onError(err, handler);
  }
}

/// Retry interceptor with exponential backoff
class _RetryInterceptor extends Interceptor {
  _RetryInterceptor(this._dio);

  final Dio _dio;
  static const int _maxRetries = 3;
  static const Duration _initialDelay = Duration(seconds: 1);

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Only retry on network errors and 5xx server errors
    final shouldRetry = err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.response?.statusCode != null &&
            err.response!.statusCode! >= 500);

    if (!shouldRetry) {
      return handler.next(err);
    }

    // Get retry count from extra
    final retryCount = err.requestOptions.extra['retryCount'] as int? ?? 0;

    if (retryCount >= _maxRetries) {
      return handler.next(err);
    }

    // Calculate delay with exponential backoff
    final delay = _initialDelay * (1 << retryCount); // 2^retryCount

    await Future<void>.delayed(delay);

    // Increment retry count
    err.requestOptions.extra['retryCount'] = retryCount + 1;

    // Retry the request
    try {
      final response = await _dio.fetch<dynamic>(err.requestOptions);
      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }
}
