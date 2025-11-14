import 'dart:math';

import 'package:dummy/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is AuthenticatedUser) {
          context.go('/home'); // using go_router
        } else if (state is UnauthenticaterUser) {
          context.go('/login');
        } else if (state is LogoutUser) {
          context.go('/login');
        }
      },
      child: Scaffold(body: Center(child: Text('Splash Screen'))),
    );
  }
}
