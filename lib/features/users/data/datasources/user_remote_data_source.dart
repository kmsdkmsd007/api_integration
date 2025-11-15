import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/login/data/datasources/auht_local_data_source.dart';
import 'package:dummy/features/users/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRemoteDataSource {
  Future<List<UserDateModel>> getAllUsers();
  Future<Either<Failure, void>> clearUserCache();
}

class RemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  const RemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  });
  @override
  Future<List<UserDateModel>> getAllUsers() async {
    final response = await client.get(
      Uri.parse('https://reqres.in/api/users?page=1'),
      headers: {'x-api-key': 'reqres-free-v1'},
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final List<dynamic> userListJson = decodedJson['data'];

      final List<UserDateModel> users = userListJson
          .map((e) => UserDateModel.fromJson(e))
          .toList();
      print(users);
      return users;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<Either<Failure, void>> clearUserCache() async {
    await sharedPreferences.remove(CACHED_USER);
    return Right(null);
  }
}
