import 'package:dummy/features/login/presentation/bloc/login_bloc.dart';
import 'package:dummy/features/login/presentation/widgets/email_input_widget.dart';
import 'package:dummy/features/login/presentation/widgets/login_button.dart';
import 'package:dummy/features/login/presentation/widgets/password_input_widget.dart';
import 'package:dummy/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    _loginBloc = LoginBloc(loginUserCase: sl());
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Screen'), backgroundColor: Colors.blue),
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
                LoginButtonWidget(fromKey: _fromKey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
