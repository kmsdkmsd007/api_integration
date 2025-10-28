import 'dart:convert';

import 'package:dummy/features/users/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<List<UserDateModel>> getAllUsers();
}

class RemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  const RemoteDataSourceImpl({required this.client});
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
}
