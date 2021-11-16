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
  int milliseconds = 0;
  late Timer timer;
  final laps = <int>[];

  void _lap() {
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 100), _onTick);

    setState(() {
      isTicking = true;
      laps.clear();
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
      milliseconds += 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildCounter(context)),
          Expanded(child: _buildLapDisplay()),
        ],
      ),
    );
  }

  Widget _buildCounter(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Lap ${laps.length + 1}',
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white),
          ),
          Text(
            _secondsText(milliseconds),
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white),
          ),
          SizedBox(height: 20),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: Text('Start'),
          onPressed: () {
            _startTimer();
          },
        ),
        SizedBox(width: 20),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          onPressed: () {
            _lap();
          },
          child: Text('Lap'),
        ),
        SizedBox(width: 20),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(Colors.red),
            foregroundColor: MaterialStateProperty.all<Color?>(Colors.white),
          ),
          onPressed: () {
            _stopTimer();
          }, // _startTimer? null: _stopTimer()
          child: Text('Stop'),
        ),
      ],
    );
  }

  String _secondsText(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }

  Widget _buildLapDisplay() {
    return ListView(
      children: [
        for (int milliseconds in laps)
          ListTile(
            title: Text(_secondsText(milliseconds)),
          )
      ],
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
