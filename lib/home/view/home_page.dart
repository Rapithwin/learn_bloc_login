import 'package:flutter/material.dart';

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
