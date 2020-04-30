import 'package:provider/provider.dart';
import 'package:timetrackerreworked/logic/time_data.dart';

class TimeTracker {
  TimeTracker({this.timeData});
  TimeData timeData;
  bool isBuilding = true;
  bool isNegative = false;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;


  void updateTrackerUsingSeconds({timeInSeconds, updatingState}) {
    if (timeInSeconds < 0)
      isNegative = true;
    var remainderSeconds = timeInSeconds.abs();

    var tempHours = (remainderSeconds - (remainderSeconds%3600)) / 3600;
    remainderSeconds = remainderSeconds%3600;
    var tempMinutes = (remainderSeconds - (remainderSeconds%60)) / 60;
    remainderSeconds = remainderSeconds%60;
    var tempSeconds = remainderSeconds;

    if (isNegative) {
      hours = -(tempHours.toInt());
      minutes = -(tempMinutes.toInt());
      seconds = -(tempSeconds.toInt());
    } else {
      hours = tempHours.toInt();
      minutes = tempMinutes.toInt();
      seconds = tempSeconds.toInt();
    }
  }

  void increasingTime() {
    if (isNegative) {
      if (hours == 0 && minutes == 0 && seconds == 0) {
        isNegative = false;
      }
      else if (seconds == 0 && minutes == 0) {
        hours++;
        minutes = -59;
        seconds = -60;
      }
      else if (seconds == 0) {
        minutes++;
        seconds = -60;
      }
    }
    else {
      if (seconds == 59) {
        minutes++;
        seconds = -1;
      }
      if (minutes == 60) {
        hours++;
        minutes = 0;
      }
    }
    seconds++;
    timeData.updateTimeValues(hours: hours, minutes: minutes, seconds: seconds, isNegative: isNegative);
  }
  void decreasingTime() {
    if (hours == 0 && minutes == 0 && seconds == 0) {
      isNegative = true;
    }
    if (isNegative == false) {
      if (minutes == 0 && seconds == 0 && hours > -1) {
        hours--;
        minutes = 59;
        seconds = 60;
      } else if (seconds == 0) {
        minutes--;
        seconds = 60;
      }
    } else {
      if (minutes == -59 && seconds == -59) {
        minutes = 0;
        seconds = 1;
        hours--;
      } else if (seconds == -59) {
        minutes--;
        seconds = 1;
      }
    }
    seconds--;
    timeData.updateTimeValues(hours: hours, minutes: minutes, seconds: seconds, isNegative: isNegative);
  }
  void tickTime() {
    if (isBuilding)
      increasingTime();
    else
      decreasingTime();
  }
}
