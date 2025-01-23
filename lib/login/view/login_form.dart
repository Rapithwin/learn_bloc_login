import 'package:bloc_login/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("Authentication failed."),
              ),
            );
        }
      },
      child: Align(
        alignment: Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput();

  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((LoginBloc bloc) => bloc.state.username.displayError);
    return TextField(
      key: const Key("loginForm_usernameInput_textField"),
      onChanged: (username) => context.read<LoginBloc>().add(
            LoginUsernameChanged(username),
          ),
      decoration: InputDecoration(
        labelText: 'username',
        errorText: displayError != null ? 'invalid username' : null,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    final displayError =
        context.select((LoginBloc bloc) => bloc.state.password.displayError);
    return TextField(
      key: const Key("loginForm_passwordInput_textField"),
      onChanged: (username) => context.read<LoginBloc>().add(
            LoginPasswordChanged(username),
          ),
      decoration: InputDecoration(
        labelText: 'passowrd',
        errorText: displayError != null ? 'invalid password' : null,
      ),
    );
  }
}
