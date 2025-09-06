import 'package:dummy/features/login/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should test the entity user ', () {
    const user = User(id: '1', name: 'kashif', email: '@gmail.com');

    expect(user.email, '@gmail.com');
    expect(user.name, 'kashif');
    expect(user.id, '1');
  });
}
