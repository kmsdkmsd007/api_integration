import 'dart:convert';

import 'package:dummy/features/login/data/models/auth_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<AuthTokenModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthTokenModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('https://reqres.in/api/login'),
      body: {'email': email, 'password': password},
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return AuthTokenModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
