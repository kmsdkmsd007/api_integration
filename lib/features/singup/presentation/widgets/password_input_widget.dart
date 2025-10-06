import 'package:dummy/features/login/presentation/bloc/login_bloc.dart';
import 'package:dummy/features/singup/presentation/bloc/singup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordInputWidget extends StatelessWidget {
  const PasswordInputWidget({super.key, required this.passwordFocusNode});
  final FocusNode passwordFocusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingupBloc, SingupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          focusNode: passwordFocusNode,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          onChanged: (value) => context.read<SingupBloc>().add(
            RegisterPasswordChanged(password: value),
          ),
        );
      },
    );
  }
}
