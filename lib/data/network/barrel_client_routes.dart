/// API client layer: Dio client, interceptors, types, and response handling.
///
/// export the main client:
/// ```dart
/// export 'package:nutritionist_app/api_client/barrel_client_routes.dart';
/// ```
library;

export 'api_types.dart';
export 'api_status.dart';
export 'dio_api_client.dart';
export 'dio_auth_interceptor.dart';
export 'dio_logging_interceptor.dart';
export 'dio_response_handler.dart';
export '../../configs/api_constants/api_base_url.dart';
export '../exceptions/app_exceptions.dart';


