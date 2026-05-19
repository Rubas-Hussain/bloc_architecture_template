import 'package:bloc_todo_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/home/presentation/bloc/home_bloc.dart';
import '../features/login/bloc/login_bloc.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<HomeBloc>(create: (_) => getIt<HomeBloc>()),
    BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
  ];
}