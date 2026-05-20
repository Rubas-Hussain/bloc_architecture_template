import 'package:bloc_todo_app/app.dart';
import 'package:bloc_todo_app/configs/bloc_providers.dart';
import 'package:bloc_todo_app/configs/routes.dart';
import 'package:bloc_todo_app/di/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'utils/responsive_util.dart';

GetIt getIt =GetIt.instance;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.setupDI();
  runApp(const MyApp());
}
