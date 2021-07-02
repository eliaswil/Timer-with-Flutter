import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyStopWatch extends StatefulWidget {
  MyStopWatch({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyStopWatchState createState() => _MyStopWatchState();
}



class _MyStopWatchState extends State<MyStopWatch> {
  int _time = 0;
  int _timeStart = 0;
  String _timeFormatted = "00:00:00.00";

  Timer? _timer;
  bool _startedTimer = false;

  final NumberFormat _formatter = new NumberFormat("00");
  final NumberFormat _formatterM = new NumberFormat("000");
  final NumberFormat _formatterF = new NumberFormat("0");


  void _incrementTimeEveryMilliSecond(){
    _time += 100;
    print('time: ' + _time.toString());

    int anyFractionOfASecond = (_time/100).floor() % 10;
    int newSeconds = (_time/1000).floor() % 60;
    int newMinutes = (_time/1000/60).floor() % 60;
    int newHours = (_time / 1000 / 60 / 60).floor();

    String formattedText = _formatter.format(newHours) + 
        ":" + _formatter.format(newMinutes) + 
        ":" + _formatter.format(newSeconds) + 
        '.' + _formatterF.format(anyFractionOfASecond);

    print('updating.. ' + formattedText);



    setState((){
      _timeFormatted = formattedText;
    });
  }

  void _onStart(){
    _timeStart = DateTime.now().millisecondsSinceEpoch;
    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) => _incrementTimeEveryMilliSecond());
    // _timer = Timer.periodic(Duration(microseconds: _microFactor ~/ _factor), (Timer t) => _incrementTimeEveryMilliSecond());

    setState((){
      _startedTimer = true;
    });
  }


  void _onStop(){
    _timer?.cancel();
    _time = 0;
    
    int timeNow = DateTime.now().millisecondsSinceEpoch;
    int timePassed = timeNow - _timeStart;
    print('passed: '+ timePassed.toString());

    int hours = timePassed/1000/60~/60;
    int minutes = (timePassed/1000~/60) % 60;
    int seconds = (timePassed~/1000) % 60;
    int millies = timePassed % 1000;


    setState((){
      // _timeFormatted = "00:00:00.00";
      _timeFormatted = _formatter.format(hours) + ":" + _formatter.format(minutes) + ":" + _formatter.format(seconds) + '.' + _formatterM.format(millies);
      _startedTimer = false;
    });
  }



  @override
  void initState() {
    super.initState();
    // timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _incrementTimeEverySecond());
  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),

      
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_timeFormatted',
              style: Theme.of(context).textTheme.headline4,
            ),
            OutlinedButton(
              onPressed: _startedTimer ? _onStop : _onStart,
              child: Text(_startedTimer ? 'Stop' : 'Start')
            ),
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementTimeEveryMilliSecond,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.

      
    );
  }
}
