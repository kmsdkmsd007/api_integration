import 'package:dummy/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          if (state is SplashLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AuthenticatedUser) {
            return const Text('User not authenticated. Please log in.');
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<SplashCubit>().checkAuthentication();
                },
                child: Text('data'),
              ),
            );
          }
        },
      ),
    );
  }
}
