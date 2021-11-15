import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  bool isTicking = true;
  int seconds = 0;
  late Timer timer;

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), _onTick);

    setState(() {
      isTicking = true;
    });
  }

  void _stopTimer() {
    timer.cancel();

    setState(() {
      isTicking = false;
    });
  }

  void _onTick(Timer time) {
    setState(() {
      ++seconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$seconds ${_secondsText()}',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text('Start'),
                onPressed: () {
                  _startTimer();
                },
              ),
              SizedBox(width: 20),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(Colors.red),
                  foregroundColor:
                      MaterialStateProperty.all<Color?>(Colors.white),
                ),
                onPressed: () {
                  _stopTimer();
                }, // _startTimer? null: _stopTimer()
                child: Text('Stop'),
              ),
            ],
          ),
        ],
      ),
    );
  }


  String _secondsText() => seconds == 1 ? 'second' : 'seconds';

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
