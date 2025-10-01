import 'dart:convert';

import 'package:dummy/features/singup/data/models/sign_up_model.dart';
import 'package:http/http.dart' as http;

abstract class SignupRemoteDataSource {
  Future<SignUpModel> registerWithEmailPassword(String email, String passwords);
}

class SignupRemoteDataSourceImpl implements SignupRemoteDataSource {
  final http.Client client;
  const SignupRemoteDataSourceImpl({required this.client});

  @override
  Future<SignUpModel> registerWithEmailPassword(
    String email,
    String password,
  ) async {
    final response = await client.post(
      Uri.parse('https://reqres.in/api/refister'),
      body: {'email': email, 'password': password},
      headers: {'x-api-key': 'reqres-api-v1'},
    );
    if (response.statusCode == 200) {
      return SignUpModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
