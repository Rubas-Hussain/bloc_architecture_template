import 'package:equatable/equatable.dart';
// part of 'home_bloc.dart';
//
// @immutable
// sealed class HomeEvent {}


abstract class LoginEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// class IncrementEvent extends LoginEvent{}
class UpdateEmailEvent extends LoginEvent{
  final String email;

  UpdateEmailEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class UpdatePasswordEvent extends LoginEvent{
  final String password;

  UpdatePasswordEvent(this.password);

  @override
  List<Object?> get props => [password];
}

class TogglePasswordEvent extends LoginEvent{
  // final bool isPasswordHidden;
  //
  // TogglePasswordEvent(this.isPasswordHidden);
  //
  // @override
  // List<Object?> get props => [isPasswordHidden];
}

class LoginApiEvent extends LoginEvent{}
