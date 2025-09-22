import 'package:dummy/features/login/presentation/bloc/login_bloc.dart';
import 'package:dummy/features/login/presentation/widgets/custom_button.dart';
import 'package:dummy/features/login/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc, LoginState>(
        create: (context) => LoginBloc(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              SizedBox(height: 123),
              EmailWidget(text: 'Enter your email'),
              EmailWidget(text: 'Enter your password'),
              CustomButton(label: '   Login   ', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
