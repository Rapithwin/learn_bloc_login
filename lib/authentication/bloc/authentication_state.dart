part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  /// The defult state. The bloc does not yet know whether the current user is authorized or not
  const AuthenticationState.unknown() : this._();

  /// Indicates that the user is current authorized
  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  /// Indicates that the user is current not authorized
  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object?> get props => [status, user];
}
