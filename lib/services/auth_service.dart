import 'package:bloc_todo_app/data/network/barrel_client_routes.dart';
import 'package:bloc_todo_app/data/exceptions/app_exceptions.dart';
import 'package:bloc_todo_app/models/user_models/user_model.dart';
import 'package:bloc_todo_app/utils/error_utls.dart';

import '../configs/api_constants/api_endpoints.dart';
import 'service_response.dart';

class AuthService {

  static final DioApiClient _dioApiClient = DioApiClient();

  static Future<ServiceResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioApiClient.callApi(
        endPoint: ApiEndpoints.loginEndPoint,
        method: ApiHTTPMethod.post,
        body: {
          'username': email,
          'password': password,
        },
        options: ApiRequestOptions(requireAuth: false),
      );

      print('Response After sign in : $response');

      if (response is AppException) {
        return ServiceResponse.error(
          data: null,
          message: ErrorUtils.messageFromException(response),
        );
      }

      if (response is Map<String, dynamic>) {
        return ServiceResponse.success(
          message: 'Login Successful',
          data: UserModel.fromJson(response),
        );
      }

      return ServiceResponse.error(
        data: null,
        message: 'Login failed: Invalid Server Response',
      );
    } catch (_) {
      return ServiceResponse.error(data: null, message: 'Login failed');
    }
  }

}