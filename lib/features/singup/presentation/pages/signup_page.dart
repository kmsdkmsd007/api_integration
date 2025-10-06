import 'package:dummy/features/login/presentation/widgets/email_input_widget.dart';
import 'package:dummy/features/login/presentation/widgets/login_button.dart';
import 'package:dummy/features/login/presentation/widgets/password_input_widget.dart';
import 'package:dummy/features/singup/presentation/bloc/singup_bloc.dart';
import 'package:dummy/features/singup/presentation/widgets/password_confrom_input_widget%20.dart';
import 'package:dummy/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  final emailFoucsNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final _fromKey = GlobalKey<FormState>();
  late SingupBloc _singupBloc;
  @override
  void initState() {
    super.initState();
    _singupBloc = SingupBloc(registerUsecas: sl());
  }

  @override
  void dispose() {
    super.dispose();
    _singupBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up '), backgroundColor: Colors.blue),
      body: BlocProvider(
        create: (_) => _singupBloc,
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
                PasswordConfromInputWidget(
                  passwordFocusNode: passwordFocusNode,
                ),
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
