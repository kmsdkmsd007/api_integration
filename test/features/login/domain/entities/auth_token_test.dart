import 'package:dummy/features/login/domain/entities/auth_token.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should test the entity user ', () {
    const user = AuthToken(token: 'qwerty1234');

    expect(user.token, 'qwerty1234');
  });
}
