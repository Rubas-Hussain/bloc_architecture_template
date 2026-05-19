import 'dart:io';
import 'barrel_client_routes.dart';
import 'package:dio/dio.dart';


class DioResponseHandler {

  DioResponseHandler({
    void Function()? showLoader,
    void Function(String message)? showErrorPopUp,
  });

  Future handleResponse({required response})async{
    try{
      final statusCode = response.statusCode;
      final data = response.data;
      if(statusCode >= 200 && statusCode < 300){
        // final jsonResponse = jsonDecode(data);
        // return jsonResponse;
        return data;
      }else{
        return _handleHttpError(statusCode,data);
      }
    }catch(e){
      return handleError(error: e);
    }
  }

  dynamic handleError({required dynamic error,}) {

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          // _showErrorPopUp('Network request timed out.');
          return TimeoutException();
        case DioExceptionType.connectionError:
          final inner = error.error;
          if (inner is SocketException) {
            return NoInternetException();
            // _showErrorPopUp(_messageForSocketException(inner));
          } else {
            // _showErrorPopUp('Unable to connect to server.');
            // Firebase Crashlytics here
            return ServerException();
            // _showErrorPopUp('Unable to connect. Something went wrong.');
          }
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode ?? 0;
          final data = error.response?.data;
          return _handleHttpError(statusCode, data);
        default:
          return UnknownErrorException();
      }
    } else if (error is SocketException) {
      // _showErrorPopUp(_messageForSocketException(error));
      return NoInternetException();
    } /*else {
      return NoInternetException();
      _showErrorPopUp(error.toString());
    }*/
    return null;
  }

  _handleHttpError(int statusCode, dynamic data) {
    final errorMessage = _extractErrorMessage(data);
    switch (statusCode) {
      case 400:
        return BadRequestException(errorMessage);
      case 401:
        // SharedPreferencesService.clear();
        // NavigationUtils.navigateOFFALLAnimationRightToLeft(LoginScreen());
        return UnAuthorizedException(errorMessage);
      case 403:
        // errorMessage = 'You do not have permission to perform this action.';
        /// Refresh Token logic here
        // SharedPreferencesService.clear();
        // NavigationUtils.navigateOFFALLAnimationRightToLeft(LoginScreen());
        return UnAuthorizedException(errorMessage);
      case 404:
        return NotFoundException(errorMessage);
        // Firebase Crashlytics here
      default:
        if (statusCode >= 500) {
          return ServerException(errorMessage);
          // Firebase Crashlytics here
        }
        return UnknownErrorException(errorMessage);
    }
  }

  String _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      final directMessage = data['message'];
      if (directMessage is String && directMessage.trim().isNotEmpty) {
        return directMessage;
      }
      final error = data['error'];
      if (error is String && error.trim().isNotEmpty) {
        return error;
      }
    }
    if (data is String && data.trim().isNotEmpty) {
      return data;
    }
    return 'Something went wrong';
  }
}