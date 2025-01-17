import 'package:user_repository/src/models/user.dart';
import 'package:uuid/uuid.dart';

/// Exposes a `getUser()` method which retrieves the current user
class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(
        const Uuid().v4(),
      ),
    );
  }
}
