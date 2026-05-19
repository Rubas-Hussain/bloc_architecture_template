class AppException implements Exception{
  final int? _statusCode;
  final String? _message;

  AppException([this._statusCode,this._message,]);

  int? get statusCode => _statusCode;
  String? get message => _message;

  @override
  String toString() {
    return 'Status Code: $_statusCode, Exception : $_message}';
  }
}

class NoInternetException extends AppException{
  NoInternetException([String? message]) : super(null,message ?? 'No internet connection');
}

class UnAuthorizedException extends AppException{
  UnAuthorizedException([String? message]) : super(401,message ?? 'Unauthorized request');
}

class SessionExpiredException extends AppException{
  SessionExpiredException([String? message]) : super(401,message ?? 'Session expired');
}

class TimeoutException extends AppException {
  TimeoutException([String? message]) : super(408, message ?? 'Request timed out');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(400, message ?? 'Bad request');
}

class NotFoundException extends AppException {
  NotFoundException([String? message]) : super(404, message ?? 'Not Found');
}

class ServerException extends AppException {
  ServerException([String? message]) : super(500, message ?? 'Internal server error');
}

class UnknownErrorException extends AppException {
  UnknownErrorException([String? message]) : super(500, message ?? 'Something went wrong');
}

