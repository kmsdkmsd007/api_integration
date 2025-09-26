import 'package:dummy/core/utils/routes_name.dart';
import 'package:dummy/features/login/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static MaterialPageRoute ongenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (_) => Container());
      case RoutesName.home:
        return MaterialPageRoute(builder: (_) => Container());
      case RoutesName.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text(
                  'Page not found',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        );
    }
  }
}
