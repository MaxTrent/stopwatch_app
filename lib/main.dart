import 'package:flutter/material.dart';
import 'package:stopwatch/login_screen.dart';
import './stopwatch.dart';

void main() {
  runApp(StopWatchApp());
}

class StopWatchApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LoginScreen(),
        LoginScreen.route: (context) => LoginScreen(),
        StopWatch.route: (context) => StopWatch(),
      },
      initialRoute: '/',
    );
  }
}