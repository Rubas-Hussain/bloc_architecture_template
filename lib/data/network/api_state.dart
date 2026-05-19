import "barrel_client_routes.dart";

class ApiState<T> {
  final ApiStatus status;
  final T? data;
  final String? message;
  final int? code;

  ApiState({
    this.status = ApiStatus.idle,
    this.data,
    this.message,
    this.code,
  });
  bool get isLoading => status == ApiStatus.loading;
  bool get isError => status == ApiStatus.error;
  bool get isSuccess => status == ApiStatus.success;

  ApiState<T> copyWith({
    ApiStatus? status,
    T? data,
    String? message,
    int? code,
  }) {
    return ApiState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}