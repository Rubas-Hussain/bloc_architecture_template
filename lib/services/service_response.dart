// import 'package:flutter/widgets.dart';
//
// import '../enums/status_enum.dart';


// class ServiceResponse<T> {
//   final T? data;
//   final String message;
//   final bool? success;
//
//   ServiceResponse({
//     this.data,
//     this.success=false,
//     this.message='',
//   });
// }
class ServiceResponse<T> {
  final T? data;
  final String message;
  final bool success;

  const ServiceResponse({
    this.data,
    this.success = false,
    required this.message,
  });

  // Factory for success
  factory ServiceResponse.success({T? data, String message = ''}) {
    return ServiceResponse(data: data, success: true, message: message);
  }

  // Factory for errors
  factory ServiceResponse.error({String message='', T? data}) {
    return ServiceResponse(data: data, success: false, message: message);
  }
}


// class ApiResponse<T> {
//   ApiResponse();
//
//   Status status = Status.UNDETERMINED;
//
//   ConnectionState connectionStatus = ConnectionState.none;
//
//   late T data;
//
//   String message = '';
//
//   List errors = [];
//
//   ApiResponse.undertermined() : status = Status.UNDETERMINED;
//
//   ApiResponse.loading(this.message) : status = Status.LOADING;
//
//   ApiResponse.completed(this.data) : status = Status.COMPLETED;
//
//   ApiResponse.error(this.message) : status = Status.ERROR;
//
//   ApiResponse.loadingMore(this.message) : status = Status.LOADING_MORE;
//
//   ApiResponse.errors(this.errors) : status = Status.ERROR;
//
//   ApiResponse.noInternet(this.message) : status = Status.NOINTERNET;
// }

