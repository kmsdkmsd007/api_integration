import 'package:dummy/features/login/presentation/bloc/login_bloc.dart';
import 'package:dummy/features/singup/presentation/bloc/singup_bloc.dart';
import 'package:dummy/features/singup/presentation/pages/signup_page.dart';
import 'package:dummy/features/users/presentation/cubit/users_cubit.dart';
import 'package:dummy/features/users/presentation/pages/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<SingupBloc>()),
        BlocProvider(create: (_) => di.sl<LoginBloc>()),
        BlocProvider(create: (_) => di.sl<UsersCubit>()),
      ],

      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: UserScreen(),
      ),
    );
  }
}
