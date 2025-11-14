import 'package:dummy/core/routes/routes_name.dart';
import 'package:dummy/core/utils/enum.dart';
import 'package:dummy/core/utils/flush_bar_helper.dart';
import 'package:dummy/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //TODO: controllers and form key

  TextEditingController emailController = TextEditingController(
    text: 'eve.holt@reqres.in',
  );
  TextEditingController passwordController = TextEditingController(
    text: 'cityslicka',
  );
  final _fromKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Screen'), backgroundColor: Colors.blue),
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: context.read<LoginBloc>(),
        listener: (context, state) {
          if (state.loginStatus == Status.loading) {
            FlushBarHelper.flushBarLoadingMessage(
              context,
              "Logging in, please wait...",
            );
          } else if (state.loginStatus == Status.success) {
            context.go(RoutesNames.home);
            FlushBarHelper.flushBarSuccessMessage(
              context,
              'Login successful: ${state.message}',
            );
          } else if (state.loginStatus == Status.error) {
            FlushBarHelper.flushBarErrorMessage(
              context,
              'Login failed: ${state.message}',
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _fromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Enter the passwaord'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),

                      label: Text('Enter the passwaord'),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  // LoginButtonWidget(fromKey: _fromKey),
                  ElevatedButton(
                    onPressed: () {
                      if (_fromKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(
                          LoginApiEvent(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill in all fields'),
                          ),
                        );
                      }
                    },
                    child: state.loginStatus == Status.loading
                        ? CircularProgressIndicator()
                        : const Text('Login'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
