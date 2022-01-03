import 'package:feature_oriented/feature/login/presentation/page/login.dart';
import 'package:flutter/material.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: LoginPage(),
  );
}