import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;

import 'barrel_client_routes.dart';
import 'package:dio/dio.dart';


/// Dio-based API client with interceptors and centralized response handling.
///
/// Usage:
/// ```dart
/// final client = DioApiClient();
/// final data = await client.callApi(
///   endPoint: '/v1/users',
///   method: ApiHTTPMethod.get,
///   options: const ApiRequestOptions(showLoader: true),
/// );
/// ```
class DioApiClient {
  DioApiClient({
    BaseOptions? baseOptions,
    DioAuthInterceptor? authInterceptor,
    DioLoggingInterceptor? loggingInterceptor,
    DioResponseHandler? responseHandler,
  })  : _dio = _createDio(baseOptions ?? _defaultBaseOptions),
        _responseHandler = responseHandler ?? DioResponseHandler() {
    _dio.interceptors.addAll([
      authInterceptor ?? DioAuthInterceptor(),
      loggingInterceptor ?? DioLoggingInterceptor(),
    ]);
  }

  final Dio _dio;
  final DioResponseHandler _responseHandler;

  static BaseOptions get _defaultBaseOptions => BaseOptions(
        baseUrl: ApiBaseUrl.dioClientBaseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        headers: <String, dynamic>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

  static Dio _createDio(BaseOptions options) => Dio(options);

  /// Expose Dio for advanced use (e.g. file upload, custom interceptors).
  Dio get dio => _dio;

  /// Call the API with the given [endPoint], [method], and optional parameters.
  ///
  /// [endPoint] is path only (e.g. '/v1/meals'). [queryParams] and [body]
  /// are sent as query string and JSON body respectively when applicable.
  /// [options] controls auth and loader behavior.
  Future<dynamic> callApi({
    required String endPoint,
    required ApiHTTPMethod method,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    Object? body,
    ApiRequestOptions options = ApiRequestOptions.defaults,
  }) async {
    // if (options.showLoader) _responseHandler.showLoader();

    final requestOptions = Options(
      method: _methodToString(method),
      headers: headers,
      extra: <String, dynamic>{
        'require_auth': options.requireAuth,
      },
      sendTimeout: options.sendTimeout,
      receiveTimeout: options.receiveTimeout,
    );

    try {
      final response = await _dio.request<dynamic>(
        endPoint,
        data: body,
        queryParameters: queryParams,
        options: requestOptions,
      );
      return _responseHandler.handleResponse(
        response: response,
        // showLoader: options.showLoader,
      );
    } catch (e, s) {
      if (kDebugMode) {
        debugPrint('DioApiClient.callApi: $e\n$s');
      }
      return _responseHandler.handleError(
        error: e,
        // showLoader: options.showLoader,
      );
    }
  }

  static String _methodToString(ApiHTTPMethod method) {
    return switch (method) {
      ApiHTTPMethod.get => 'GET',
      ApiHTTPMethod.post => 'POST',
      ApiHTTPMethod.put => 'PUT',
      ApiHTTPMethod.patch => 'PATCH',
      ApiHTTPMethod.delete => 'DELETE',
    };
  }
}
