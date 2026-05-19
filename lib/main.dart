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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.providers,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        builder: (_, child) {
          ResponsiveUtil.init(context);
          return child!;
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: AppRoutes.router,
      ),
    );
  }
}