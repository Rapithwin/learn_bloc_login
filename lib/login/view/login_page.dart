import 'package:authentication_repository/authenticationi_repository.dart';
import 'package:bloc_login/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The [LoginPage] is responsible for exposing the [Route] as well as
/// creating and providing the [LoginBloc] to the [LoginForm].
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() => MaterialPageRoute<void>(
        builder: (context) => LoginPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) => LoginBloc(
            // `context.read<AuthenticationRepository>()` is used to
            // lookup the instance of AuthenticationRepository via
            // the BuildContext.
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
          child: LoginForm(),
        ),
      ),
    );
  }
}
