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
  bool _isPaused = false;

  final NumberFormat _formatter = new NumberFormat("00");
  final NumberFormat _formatterM = new NumberFormat("000");
  final NumberFormat _formatterF = new NumberFormat("0");




  void _incrementTimeEveryMilliSecond(){
    _time += 100;

    int anyFractionOfASecond = (_time/100).floor() % 10;
    int newSeconds = (_time/1000).floor() % 60;
    int newMinutes = (_time/1000/60).floor() % 60;
    int newHours = (_time / 1000 / 60 / 60).floor();

    String formattedText = _formatter.format(newHours) + 
        ":" + _formatter.format(newMinutes) + 
        ":" + _formatter.format(newSeconds) + 
        '.' + _formatterF.format(anyFractionOfASecond);


    setState((){
      _timeFormatted = formattedText;
    });
  }




  void _onStart(){
    if(!_startedTimer && !_isPaused){
      _timeStart = DateTime.now().millisecondsSinceEpoch;
      _time = 0;
    }

    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) => _incrementTimeEveryMilliSecond());

    setState((){
      _startedTimer = true;
      _isPaused = false;
    });
  }


  void _onReset(){
    setState((){
      _time = 0;
      _timeFormatted = "00:00:00.0";
      _isPaused = false;
      _startedTimer = false;
    });
  }




  void _onStop(bool isPaused){
    _timer?.cancel();

    int timeNow = DateTime.now().millisecondsSinceEpoch;
    int timePassed = timeNow - _timeStart;
    _time = timePassed;

    print('passed: '+ timePassed.toString());

    int hours = timePassed/1000/60~/60;
    int minutes = (timePassed/1000~/60) % 60;
    int seconds = (timePassed~/1000) % 60;
    int millies = timePassed % 1000;


    setState((){
      _timeFormatted = _formatter.format(hours) + ":" + _formatter.format(minutes) + ":" + _formatter.format(seconds) + '.' + _formatterM.format(millies);
      _startedTimer = false;
      _isPaused = isPaused;
    });
  }



  void _onRound(){
    print('onRound: TODO');
  }






  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }







  @override
  Widget build(BuildContext context) {
    print('started? ' + _startedTimer.toString());

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

            

            // Displayed Time
            Row(
              children: <Widget>[
                Text(
                  '$_timeFormatted'.split('.')[0],
                  // style: Theme.of(context).textTheme.headline4,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w400,

                  ),
                ),
                Text(
                  '.'+'$_timeFormatted'.split('.')[1],
                  // style: Theme.of(context).textTheme.headline4,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.3),
                    fontSize: 40,
                    fontWeight: FontWeight.w300,

                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),



            // space between text and button
            SizedBox(height: 50), 





            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                // button: Start/Stop/continue
                Material(
                  // color: _startedTimer ? Theme.of(context).colorScheme.secondary.withOpacity(0.6) : Theme.of(context).accentColor.withOpacity(0.6),
                  // color: _startedTimer ? Theme.of(context).colorScheme.secondary.withOpacity(0.6) : Theme.of(context).colorScheme.primary.withOpacity(0.9),
                  color: _startedTimer ? Theme.of(context).colorScheme.primary.withOpacity(0.6) : Theme.of(context).colorScheme.secondary.withOpacity(0.6),

                  borderRadius: BorderRadius.circular(18.0),

                  child: InkWell(
                    onTapDown: (TapDownDetails details){_startedTimer ? _onStop(true) : _onStart();},
                    onTap: (){},
                    child: Container(
                      child: Center(
                        child: Text(
                          _startedTimer ? 'Stop' : _isPaused ? 'Continue' : 'Start',
                          style: TextStyle(
                            color: Colors.black
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      height: 50,
                      width: 100,
                    
                    ),



                    splashColor: Theme.of(context).colorScheme.secondaryVariant,
                    highlightColor: Theme.of(context).colorScheme.primaryVariant,
                    overlayColor: MaterialStateProperty.all(Colors.white),

                    borderRadius: BorderRadius.circular(18.0),


                  ),

                ),


                // button: reset/round
                if(_time > 0) ...[

                  SizedBox(width: 30),

                  // Button
                  Material(
                    color: _isPaused ? Colors.blue.withOpacity(0.6) : Colors.greenAccent.withOpacity(0.6),
                    // color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),

                    borderRadius: BorderRadius.circular(18.0),

                    child: InkWell(
                      onTapDown: (TapDownDetails details){_isPaused ? _onReset() : _onRound();},
                      onTap: (){},
                      child: Container(
                        child: Center(
                          child: Text(
                            _isPaused ? 'Reset' : 'Round',
                            style: TextStyle(
                              color: Colors.black
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        height: 50,
                        width: 100,
                      
                      ),

                      splashColor: Theme.of(context).colorScheme.secondaryVariant,
                      highlightColor: Theme.of(context).colorScheme.primaryVariant,
                      overlayColor: MaterialStateProperty.all(Colors.white),

                      borderRadius: BorderRadius.circular(18.0),


                    ),

                  ),

                ],




              ],
            ),






          ],
        ),
      ),
      



    );
  }
}
