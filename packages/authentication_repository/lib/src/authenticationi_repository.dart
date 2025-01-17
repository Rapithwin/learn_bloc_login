import 'dart:async';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

/// [AuthenticationRepository] exposses a `Stream` of [AuthenticationStatus] updates
/// Which will be used to notify the application when a user signs in or out.
class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() {
    _controller.close();
  }
}
