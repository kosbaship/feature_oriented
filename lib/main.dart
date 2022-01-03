import 'package:flutter/material.dart';
import 'app/injection_container.dart' as di; //Dependency injector
import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.configureInjection();
  runApp(const App());
}
