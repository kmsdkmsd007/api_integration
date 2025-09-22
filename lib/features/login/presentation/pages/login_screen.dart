import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/login/login_bloc.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/repository/auth/login_repository.dart';
import 'widgets/login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailFoucsNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final _fromKey = GlobalKey<FormState>();

  late LoginBloc _loginBloc;
  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(loginRepository: getIt());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _loginBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: Colors.blue,
        ),
        body: BlocProvider(
          create: (_) => _loginBloc,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _fromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmailInputWidget(emailFoucsNode: emailFoucsNode),
                  const SizedBox(height: 16),
                  PasswordInputWidget(passwordFocusNode: passwordFocusNode),
                  const SizedBox(height: 24),
                  LoginButtonWidget(
                    fromKey: _fromKey,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
