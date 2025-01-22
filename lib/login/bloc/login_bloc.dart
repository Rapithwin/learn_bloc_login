import 'package:authentication_repository/authenticationi_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_login/login/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';
part 'login_event.dart';

/// responsible for reacting to user interactions in the `LoginForm`
/// and handling the validation and submission of the form.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate(
          [state.password, username],
        ),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate(
          [state.username, password],
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(
        state.copyWith(status: FormzSubmissionStatus.inProgress),
      );
      try {
        await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        );
        emit(
          state.copyWith(status: FormzSubmissionStatus.success),
        );
      } catch (_) {
        emit(
          state.copyWith(status: FormzSubmissionStatus.failure),
        );
      }
    }
  }
}
