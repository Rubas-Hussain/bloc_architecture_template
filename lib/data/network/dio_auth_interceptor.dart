

import 'barrel_client_routes.dart';
import 'package:dio/dio.dart';

/// Adds Bearer token to requests when [requireAuth] is true.
/// Attach to options via [Options.extra]['require_auth'].
class DioAuthInterceptor extends Interceptor {
  DioAuthInterceptor({
    String? Function()? tokenProvider,
  }) : _tokenProvider = tokenProvider ?? _defaultTokenProvider;

  final String? Function() _tokenProvider;

  static String? _defaultTokenProvider() {
    // TODO: Replace with actual token from storage, e.g.:
    // return SharedPreferencesService.getString(SharedPreferencesKeys.accessToken);
    return 'asd';
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final requireAuth = options.extra['require_auth'] as bool? ?? true;
    if (requireAuth) {
      final token = _tokenProvider();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }
}
