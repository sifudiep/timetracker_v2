import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerreworked/logic/time_data.dart';
import 'package:timetrackerreworked/logic/time_tracker.dart';

class TimeWidget extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    var timeData = Provider.of<TimeData>(context);
    var timeTracker = new TimeTracker(timeData: timeData);
    return Container(
      child: Text(
        "${timeData.counter}"
      ),
    );
  }
}
