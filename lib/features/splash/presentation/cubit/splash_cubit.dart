import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dummy/features/login/data/models/auth_model.dart';
import 'package:dummy/features/login/domain/entities/auth_token.dart';
import 'package:dummy/features/login/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SharedPreferences sharedPreferences;
  final LoginUserCase userCase;
  SplashCubit(this.sharedPreferences, this.userCase) : super(SplashInitial());

  Future<void> checkAuthentication() async {
    await Future.delayed(const Duration(seconds: 2)); // show splash a bit
    try {
      final jsonString = sharedPreferences.getString('CACHED_USER');
      if (jsonString != null) {
        final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        final user = AuthTokenModel.fromJson(jsonMap); // your model class
        emit(AuthenticatedUser(user));
      } else if (sharedPreferences.getBool('LOGOUT_USER') == true) {
        emit(LogoutUser());
      } else {
        emit(UnauthenticaterUser());
      }
    } catch (e) {
      emit(SplashError('Error checking authentication: $e'));
    }
  }
}
