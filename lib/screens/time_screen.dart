import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerreworked/logic/time_data.dart';
import 'package:timetrackerreworked/settings.dart';
import 'package:timetrackerreworked/widgets/time_widget.dart';

class TimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var timeData = Provider.of<TimeData>(context);
    return Container(
      color: Colors.lightBlueAccent,
      child: Center(
        child: TimeWidget()
      ),
    );
  }
}
