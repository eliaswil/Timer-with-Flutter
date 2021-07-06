import 'package:flutter/material.dart';

import 'screens/stopWatch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        
      ),

      home: MyStopWatch(title: 'Timer'),
    );
  }
}

