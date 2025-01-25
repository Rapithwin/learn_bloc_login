import 'package:bloc_login/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() => MaterialPageRoute<void>(
        builder: (context) => HomePage(),
      );

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _UserId extends StatelessWidget {
  const _UserId();

  @override
  Widget build(BuildContext context) {
    final userId =
        context.select((AuthenticationBloc bloc) => bloc.state.user.id);
    return Text("User ID: $userId");
  }
}
