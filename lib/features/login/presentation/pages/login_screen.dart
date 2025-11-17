import 'package:dummy/core/routes/routes_name.dart';
import 'package:dummy/core/utils/enum.dart';
import 'package:dummy/core/utils/flush_bar_helper.dart';
import 'package:dummy/core/utils/routes_name.dart';
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3E5F5), // Light purple background
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: context.read<LoginBloc>(),
        listener: (context, state) {
          if (state.loginStatus == Status.loading) {
            FlushBarHelper.flushBarLoadingMessage(
              context,
              "Logging in, please wait...",
            );
          } else if (state.loginStatus == Status.success) {
            context.go(RoutesName.home);
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
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header
                  Text(
                    'LOGIN',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Color(0xFF7B1FA2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'TO CONTINUE',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Color(0xFF9C27B0),
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 40),
                  // Form
                  Form(
                    key: _fromKey,
                    child: Column(
                      children: [
                        // Email Field
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'someone@gmail.com',
                            hintStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(Icons.email, color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFCE93D8), // Light purple
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(
                              r'^[^@]+@[^@]+\.[^@]+',
                            ).hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        // Password Field
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: '••••••••••',
                            hintStyle: TextStyle(color: Colors.white70),
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFCE93D8), // Light purple
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
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
                        ),
                        SizedBox(height: 32),
                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: state.loginStatus == Status.loading
                                ? null
                                : () {
                                    if (_fromKey.currentState!.validate()) {
                                      context.read<LoginBloc>().add(
                                        LoginApiEvent(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF7B1FA2), // Deep purple
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: state.loginStatus == Status.loading
                                ? SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 24),
                        // Sign Up Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account? ',
                              style: TextStyle(color: Color(0xFF7B1FA2)),
                            ),
                            GestureDetector(
                              onTap: () => context.go(RoutesName.register),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Color(0xFF7B1FA2),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
