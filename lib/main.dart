import 'package:disertatie/router/app_router.dart';
import 'package:flutter/material.dart';
import 'theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialTheme theme = MaterialTheme(Theme.of(context).textTheme);
    final brightness = MediaQuery.of(context).platformBrightness;

    return MaterialApp.router(
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      routerConfig: AppRouter.goRouter,
    );
  }
}
