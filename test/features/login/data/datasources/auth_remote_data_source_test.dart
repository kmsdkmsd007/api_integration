import 'package:dummy/features/login/data/datasources/auth_remote_data_source.dart';
import 'package:dummy/features/login/data/models/auth_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MockRemoteDataSourceImpl extends Mock
    implements AuthRemoteDataSourceImpl {}

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = AuthRemoteDataSourceImpl(client: mockHttpClient);
    registerFallbackValue(Uri.parse('https://dummy.com'));
  });
  const String tEmail = 'eve.holt@reqres.in';
  const String tPassword = 'cityslicka';
  const String tToken = 'qwert1234';
  final tAuthTokenModel = AuthTokenModel(token: tToken, error: '');

  test(
    'should perform the post request and return Auth Token on success',
    () async {
      when(
        () => mockHttpClient.post(
          Uri.parse('https://reqres.in/api/login'),
          body: {'email': tEmail, 'password': tPassword},
          headers: {'Content-Type': 'application/json'},
        ),
      ).thenAnswer((_) async => http.Response('{"token": "$tToken"}', 200));
      final result = await dataSource.login(tEmail, tPassword);

      expect(result, isA<AuthTokenModel>());
      expect(result.token, tToken);
    },
  );

  test('should return AuthTokenModel when the response code is 200', () async {
    when(
      () => mockHttpClient.post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer(
      (_) async => http.Response(jsonEncode({'token': tToken}), 200),
    );

    final result = await dataSource.login(tEmail, tPassword);

    expect(result, isA<AuthTokenModel>());
    expect(result.token, tToken);
  });

  test('should throw Exception when the response code is not 200', () async {
    when(
      () => mockHttpClient.post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((_) async => http.Response('Unauthorized', 401));

    expect(
      () async => await dataSource.login(tEmail, tPassword),
      throwsException,
    );
  });
}
