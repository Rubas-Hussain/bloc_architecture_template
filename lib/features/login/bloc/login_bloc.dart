import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/data/network/api_status.dart';
import 'package:bloc_todo_app/services/auth_service.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState> {
  LoginBloc() : super(LoginState()) {
    on<TogglePasswordEvent>(_togglePassword);
    on<UpdateEmailEvent>(_updateEmail);
    on<UpdatePasswordEvent>(_updatePassword);
    on<LoginApiEvent>(_login);
    // on<DecrementEvent>(_decrement);
    // on<GetPostsEvent>(_getPosts);
  }

  void _updateEmail(UpdateEmailEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _updatePassword(UpdatePasswordEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _togglePassword(TogglePasswordEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }

  Future<void> _login(LoginEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(apiStatus: ApiStatus.loading));
    // rubas@gmail.com
    final response = await AuthService.signIn(email: 'emilys', password: 'emilyspass');
    // final response = await AuthService.signIn(email: state.email, password: state.password);
    if(response.data!=null){
      print("response ==== > ${response.data}");
      emit(state.copyWith(apiStatus: ApiStatus.success,apiMessage: response.message));
      return;
    }
    emit(state.copyWith(apiStatus: ApiStatus.error,apiMessage: response.message));
    return;
  }
}
