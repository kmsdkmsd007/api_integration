import 'package:dummy/features/login/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRepositoryImpl implements RemoteDataSource {
  final http.Client client;

  AuthRepositoryImpl({required this.client});

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('https://reqres.in/api/login'),
      body: {'email': email, 'password': password},
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson({'token': 'dummy_token', 'error': ''});
    } else {
      return UserModel.fromJson({'token': '', 'error': 'Login failed'});
    }
  }
}
