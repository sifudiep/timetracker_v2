import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerreworked/screens/time_screen.dart';
import 'logic/time_data.dart';

void main() {
  Timer.periodic(Duration(seconds: 1), (timer) {
    var timeData = new TimeData();
    timeData.counter = 320;

  });
  return runApp(TimeTrackerApp());
}

class TimeTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TimeData(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => TimeScreen()
        },
        title: 'Time Tracker',
      ),
    );
  }
}

