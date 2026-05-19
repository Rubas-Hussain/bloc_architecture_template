// part of 'home_bloc.dart';
//
// @immutable
// sealed class HomeState {
//   final int counter;
//
//   const HomeState({required this.counter});
// }
//
// final class HomeInitial extends HomeState {
//   const HomeInitial({required int counter}) : super(counter: counter);
//
// }

import 'package:bloc_todo_app/data/network/api_status.dart';
import 'package:bloc_todo_app/models/user_models/user_model.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isPasswordHidden;
  final String email;
  final String password;
  final String apiMessage;
  final ApiStatus apiStatus;
  final UserModel? user;

  const LoginState({
    this.apiMessage = '',
    this.apiStatus = ApiStatus.idle,
    this.isPasswordHidden = true,
    this.user,
    this.email = '',
    this.password = '',
  });

  LoginState copyWith({
    bool? isPasswordHidden,
    UserModel? user,
    String? email,
    String? password,
    String? apiMessage,
    ApiStatus? apiStatus,
  }) {
    return LoginState(
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      user: user ?? this.user,
      email: email ?? this.email,
      password: password ?? this.password,
      apiMessage: apiMessage ?? this.apiMessage,
      apiStatus: apiStatus ?? this.apiStatus
    );
  }

  @override
  List<Object?> get props => [
    isPasswordHidden,
    email,
    password,
    apiMessage,
    apiStatus,
    user,
  ];
}
