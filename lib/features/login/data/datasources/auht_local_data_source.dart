import 'dart:convert';

import 'package:dummy/features/login/data/models/auth_model.dart';
import 'package:dummy/features/login/domain/entities/auth_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_USER = 'CACHED_USER';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(AuthToken user);
  Future<AuthToken> getLastUser();
  Future<void> clearUserCache();
}

class AuhtLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  const AuhtLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(AuthToken user) async {
    final userjson = jsonEncode((user as AuthTokenModel).toJson());
    await sharedPreferences.setString(CACHED_USER, userjson);
  }

  @override
  Future<AuthToken> getLastUser() async {
    final jsonString = sharedPreferences.getString(CACHED_USER);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      print(jsonString);
      return AuthTokenModel.fromJson(jsonMap);
    } else {
      return Future.error('No cached user found');
    }
  }

  @override
  Future<void> clearUserCache() async {
    await sharedPreferences.remove(CACHED_USER);
  }
}
