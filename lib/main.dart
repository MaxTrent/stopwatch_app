import 'package:flutter/material.dart';
import './stopwatch.dart';

void main() {
  runApp(StopWatchApp());
}

class StopWatchApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: StopWatch(),
    );
  }
}