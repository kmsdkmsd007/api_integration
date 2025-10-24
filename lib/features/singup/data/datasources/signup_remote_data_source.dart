import 'dart:convert';

import 'package:dummy/features/singup/data/models/sign_up_model.dart';
import 'package:dummy/features/singup/domain/entities/sign_up.dart';
import 'package:http/http.dart' as http;

abstract class SignupRemoteDataSource {
  Future<SignUp> registerWithEmailPassword(String email, String passwords);
}

class SignupRemoteDataSourceImpl implements SignupRemoteDataSource {
  final http.Client client;
  const SignupRemoteDataSourceImpl({required this.client});

  @override
  Future<SignUp> registerWithEmailPassword(
    String email,
    String password,
  ) async {
    var headers = {
      'x-api-key': 'reqres-free-v1',
      'Content-Type': 'application/json',
    };
    var request = http.Request(
      'POST',
      Uri.parse('https://reqres.in/api/register'),
    );
    request.body = json.encode({"email": email, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    // final response = await client.post(
    //   Uri. parse('https://reqres.in/api/register'),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'x-api-key': 'reqres-api-v1',
    //   },
    //   body: {'email': email, 'password': password},
    // );
    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      final data = jsonDecode(await response.stream.bytesToString());

      final model = SignUpModel.fromJson(data);
      return model.toEntity();
      // return SignUpModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
