import 'package:authentication_repository/authenticationi_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/// The [AuthenticationBloc] manages the authentication state of
///  the application which is used to determine things like
/// whether or not to start the user at a login page or a home page.
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepostiory = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationEvent>((event, emit) {
      on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
      on<AuthenticationLogoutPressed>(_onLogoutPressed);
    });
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepostiory;

  /// the [AuthenticationBloc] uses `emit.onEach` to subscribe to the status stream
  /// of the [AuthenticationRepository] and emit a state in response to each
  /// [AuthenticationStatus].
  Future<void> _onSubscriptionRequested(
    AuthenticationSubscriptionRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    return emit.onEach(_authenticationRepository.status,
        onData: (AuthenticationStatus status) async {
      switch (status) {
        case AuthenticationStatus.authenticated:
          final user = await _tryGetUser();
          return emit(
            user != null
                ? AuthenticationState.authenticated(user)
                : const AuthenticationState.unauthenticated(),
          );
        case AuthenticationStatus.unauthenticated:
          return emit(const AuthenticationState.unauthenticated());

        case AuthenticationStatus.unknown:
          return emit(const AuthenticationState.unknown());
      }
    }, onError: addError);
  }

  void _onLogoutPressed(
    AuthenticationLogoutPressed event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepostiory.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
