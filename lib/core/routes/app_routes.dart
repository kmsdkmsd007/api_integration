import 'package:dummy/core/routes/routes_name.dart';
import 'package:dummy/features/login/presentation/pages/login_screen.dart';
import 'package:dummy/features/singup/presentation/pages/signup_page.dart';
import 'package:dummy/features/splash/presentation/pages/splash_screen.dart';
import 'package:dummy/features/users/presentation/pages/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: RoutesNames.splash,
    routes: <RouteBase>[
      GoRoute(
        path: RoutesNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: RoutesNames.login, builder: (c, s) => const LoginScreen()),
      GoRoute(
        path: RoutesNames.register,
        builder: (c, s) => const SignupPage(),
      ),
      GoRoute(path: RoutesNames.home, builder: (c, s) => const UserScreen()),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Oops page not found'))),
  );
}
