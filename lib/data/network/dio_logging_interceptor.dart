

import 'barrel_client_routes.dart';
import 'package:dio/dio.dart';

/// Logs request and response for debugging.
class DioLoggingInterceptor extends Interceptor {
  DioLoggingInterceptor({this.enabled = true});

  final bool enabled;

  static const _startTimeKey = 'start_time';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (enabled) {
      // ignore: avoid_print
      print('[Dio] ${options.method} ${options.uri}');
      if (options.method != 'GET') {
        // ignore: avoid_print
        print('[Dio Request Body] ${options.data}');
      }
      if (options.queryParameters.isNotEmpty) {
        // ignore: avoid_print
        print('[Dio Query Params] ${options.queryParameters}');
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (enabled) {
      final startTime = response.requestOptions.extra[_startTimeKey];
      final duration = startTime != null
          ? DateTime.now().difference(startTime)
          : null;

      // ignore: avoid_print
      print(
        '[Dio] response Duration ${duration != null ? ' (${duration.inMilliseconds} ms)' : null}',
      );

      // ignore: avoid_print
      print('[Dio] ${response.statusCode} => ${response.data}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (enabled) {

      final startTime = err.requestOptions.extra[_startTimeKey];
      final duration = startTime != null
          ? DateTime.now().difference(startTime)
          : null;

      // ignore: avoid_print
      print(
        '[Dio] ERROR ${err.requestOptions.uri}'
            '${duration != null ? ' (${duration.inMilliseconds} ms)' : ''}',
      );
      // ignore: avoid_print
      print('[Dio] Error: ${err.type} ${err.message}');
    }
    handler.next(err);
  }
}
