import 'package:dummy/core/utils/enum.dart';
import 'package:dummy/core/utils/flush_bar_helper.dart';
import 'package:dummy/core/utils/routes_name.dart';
import 'package:dummy/features/login/presentation/bloc/login_bloc.dart';
import 'package:dummy/features/singup/presentation/bloc/singup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigupBotton extends StatelessWidget {
  const SigupBotton({super.key, required this.fromKey});
  final fromKey;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SingupBloc, SingupState>(
      listenWhen: (previous, current) =>
          previous.signupStatus != current.signupStatus,
      listener: (context, state) {
        if (state.signupStatus == Status.success) {
          Navigator.pushNamed(context, RoutesName.home);
          FlushBarHelper.flushBarSuccessMessage(
            context,
            'Login successful: ${state.message}',
          );
        } else if (state.signupStatus == Status.loading) {
          FlushBarHelper.flushBarLoadingMessage(
            context,
            "Logging in, please wait...",
          );
        } else if (state.signupStatus == Status.error) {
          // Optionally, navigate to another screen or perform other actions
          FlushBarHelper.flushBarErrorMessage(
            context,
            'Login failed: ${state.message}',
          );
        }
      },
      child: BlocBuilder<SingupBloc, SingupState>(
        buildWhen: (previous, current) =>
            previous.signupStatus != current.signupStatus,
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              if (fromKey.currentState!.validate()) {
                context.read<SingupBloc>().add(
                  SignUpApi(state.email, state.password),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill in all fields')),
                );
              }
            },
            child: state.signupStatus == Status.loading
                ? CircularProgressIndicator()
                : const Text('Register'),
          );
        },
      ),
    );
  }
}
