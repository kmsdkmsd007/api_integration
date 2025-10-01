import 'package:dummy/core/utils/enum.dart';
import 'package:dummy/core/utils/flush_bar_helper.dart';
import 'package:dummy/core/utils/routes_name.dart';
import 'package:dummy/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key, required this.fromKey});
  final fromKey;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          previous.loginStatus != current.loginStatus,
      listener: (context, state) {
        if (state.loginStatus == Status.success) {
          Navigator.pushNamed(context, RoutesName.home);
          FlushBarHelper.flushBarSuccessMessage(
            context,
            'Login successful: ${state.message}',
          );
        } else if (state.loginStatus == Status.loading) {
          FlushBarHelper.flushBarLoadingMessage(
            context,
            "Logging in, please wait...",
          );
        } else if (state.loginStatus == Status.error) {
          // Optionally, navigate to another screen or perform other actions
          FlushBarHelper.flushBarErrorMessage(
            context,
            'Login failed: ${state.message}',
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) =>
            previous.loginStatus != current.loginStatus,
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              if (fromKey.currentState!.validate()) {
                context.read<LoginBloc>().add(LoginApi());
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill in all fields')),
                );
              }
            },
            child: state.loginStatus == Status.loading
                ? CircularProgressIndicator()
                : const Text('Login'),
          );
        },
      ),
    );
  }
}
