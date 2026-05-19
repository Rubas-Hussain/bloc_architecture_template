import '../data/exceptions/app_exceptions.dart';

class ErrorUtils {
  static String messageFromException(AppException exception) {
    if (exception.message != null && exception.message!.trim().isNotEmpty) {
      return exception.message!;
    }
    if (exception is NoInternetException) return 'No internet connection';
    if (exception is TimeoutException) return 'Request timed out';
    if (exception is BadRequestException) return 'Invalid request';
    if (exception is UnAuthorizedException) return 'Invalid credentials';
    if (exception is NotFoundException) return 'Endpoint not found';
    if (exception is ServerException) return 'Internal server error';
    return 'Something went wrong';
  }

}