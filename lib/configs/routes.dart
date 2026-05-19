import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bloc_todo_app/configs/route_names.dart';
import 'barrel_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
class AppRoutes {

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.homeScreen,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: RouteNames.splashScreen,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: RouteNames.loginScreen,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: RouteNames.homeScreen,
        builder: (context, state) => const HomeView(),
      ),
    ],
  );
}