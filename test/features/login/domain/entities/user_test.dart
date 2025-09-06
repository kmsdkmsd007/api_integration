import 'package:dummy/features/login/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should test the entity user ', () {
    const user = User(token: 'kashif', error: '@gmail.com');

    expect(user.error, '@gmail.com');
    expect(user.token, 'kashif');
  });
}
