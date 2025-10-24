import 'package:dummy/features/singup/presentation/bloc/singup_bloc.dart';
import 'package:dummy/features/singup/presentation/widgets/password_confrom_input_widget%20.dart';
import 'package:dummy/features/singup/presentation/widgets/sign_email_input_widget.dart';
import 'package:dummy/features/singup/presentation/widgets/sign_password_input_widget.dart';
import 'package:dummy/features/singup/presentation/widgets/singn_up_button.dart';
import 'package:dummy/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  //   final emailFoucsNode = FocusNode();
  //   final passwordFocusNode = FocusNode();
  //   final conrfrompasswordFocusNode = FocusNode();
  final _fromKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController(text: 'eve.holt@reqres.in');
  final passwordCtrl = TextEditingController(text: 'pistol');
  final conrfrompasswordCtrl = TextEditingController(text: 'pistol');
  // late SingupBloc _singupBloc;
  @override
  void initState() {
    super.initState();
    // _singupBloc = SingupBloc(registerUsecas: sl());
  }

  @override
  void dispose() {
    super.dispose();
    // _singupBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up '), backgroundColor: Colors.blue),
      body: BlocBuilder<SingupBloc, SingupState>(
        builder: (c, state) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _fromKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordCtrl,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: conrfrompasswordCtrl,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password Confirmation',
                  ),
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    if (_fromKey.currentState!.validate()) {
                      context.read<SingupBloc>().add(
                        SignUpApi(emailCtrl.text, passwordCtrl.text),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all fields'),
                        ),
                      );
                    }
                  },
                  child: Text('Register'),
                ),
                //                 {
                //     "email": "eve.holt@reqres.in",
                //     "password": "pistol"
                // }
              ],
            ),
          ),
        ),
      ),
    );
  }
}
