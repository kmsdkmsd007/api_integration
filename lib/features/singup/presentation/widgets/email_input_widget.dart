import 'package:dummy/features/login/presentation/bloc/login_bloc.dart';
import 'package:dummy/features/singup/presentation/bloc/singup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailInputWidget extends StatelessWidget {
  const EmailInputWidget({super.key, required this.emailFoucsNode});
  final emailFoucsNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingupBloc, SingupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          focusNode: emailFoucsNode,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Enter a valid email';
            }
            return null;
          },
          onChanged: (value) {
            context.read<LoginBloc>().add(EmailChanged(email: value));
          },
        );
      },
    );
  }
}
