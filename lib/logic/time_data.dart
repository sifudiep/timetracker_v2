import 'package:flutter/material.dart';
import 'package:timetrackerreworked/logic/time_tracker.dart';
import 'package:timetrackerreworked/logic/data_storer.dart';

class TimeData extends ChangeNotifier {
  int hours;
  int minutes;
  int seconds;
  bool isNegative;
  int counter = 0;

  String showSeconds() {
    if (seconds.abs().toString().length == 1)
      return "0${seconds.abs()}";
    else
      return seconds.abs().toString();
  }
  String showMinutes() {
    if (minutes.abs().toString().length == 1)
      return "0${minutes.abs()}";
    else
      return minutes.abs().toString();
  }
  String showHours() {
    if (hours.abs().toString().length == 1)
      return "0${hours.abs()}";
    else
      return hours.abs().toString();
  }
  String showNegative() {
    if (isNegative)
      return "-";
    else
      return "+";
  }

  Function updateTimeValues({hours, minutes, seconds, isNegative}) {
    this.hours = hours;
    this.minutes = minutes;
    this.seconds = seconds;
    this.isNegative = isNegative;
    notifyListeners();
  }
}

