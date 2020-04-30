import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class DataStorer {
  DataStorer() {
    var directory;
    getApplicationDocumentsDirectory().then((dir) => directory);
    fileName = "${dayFormat.format(DateTime.now())}_log.txt";
    String folderName = "time_logs";
    parentDirectory = directory.path;
    calendar = new File("${directory.path}/calendar.txt");
    calendar.exists().then((exists) {
      if (!exists) {
        calendar.create();
      }
    });
    timeLogsDirectory = new Directory("${directory.path}/$folderName");
    if (timeLogsDirectory.existsSync() == false) {
      timeLogsDirectory.createSync();
    }
    timeLog = new File("${timeLogsDirectory.path}/$fileName");
    if (timeLog.existsSync() == false) {
      timeLog.createSync();
      storeTrackedTime(isBuilding: true);
    } else {
      storeTrackedTime(isBuilding: wasBuilding());
    }
    clearOldLogs();
  }
  String fileName;
  File calendar;
  Directory timeLogsDirectory;
  File timeLog;
  String parentDirectory;
  var dayFormat = DateFormat("yyyy-MM-dd");

  void storeTrackedTime({bool isBuilding}) {
    String newData =
        "${DateTime.now().hour * 3600 + DateTime.now().minute * 60 + DateTime.now().second},$isBuilding/";
    var oldData = timeLog.readAsStringSync();
    timeLog.writeAsStringSync(oldData + newData);
  }

  int retrieveTrackedTime(File file) {
    var rawTimeLog = file.readAsStringSync();
    var timeLogList = rawTimeLog.split('/');

    var timeSum = 0;
    for (var i = 0; i < timeLogList.length - 2; i++) {
      var logOne = timeLogList[i].split(',');
      var logTwo = timeLogList[i + 1].split(',');

      var difference = (int.parse(logTwo[0]) - int.parse(logOne[0]));
      bool assignPositiveValue = logOne[1] == "true";
      difference = assignPositiveValue ? difference : -difference;
      timeSum += difference;
    }
    return timeSum;
  }

  bool wasBuilding() {
    var rawTimeLog = timeLog.readAsStringSync();
    if (rawTimeLog.length >= 2) {
      var timeLogList = rawTimeLog.split('/');
      var wasBuilding = timeLogList[timeLogList.length - 2].split(',')[1];
      if (wasBuilding == "true")
        return true;
      else if (wasBuilding == "false")
        return false;
      else
        return true;
    } else {
      return true;
    }
  }

  String convertSecondsToHourFormat(int timeInSeconds) {
    String isNegative = "";
    if (timeInSeconds < 0) isNegative = "-";
    var remainderSeconds = timeInSeconds.abs();

    var actualHours = (remainderSeconds - (remainderSeconds % 3600)) / 3600;
    remainderSeconds = remainderSeconds % 3600;
    var actualMinutes = (remainderSeconds - (remainderSeconds % 60)) / 60;
    remainderSeconds = remainderSeconds % 60;
    var actualSeconds = remainderSeconds;

    var shownHours = actualHours.round().toString();
    var shownMinutes = actualMinutes.round().toString();
    var shownSeconds = actualSeconds.round().toString();

    shownHours = shownHours.length == 1 ? "0$shownHours" : shownHours;
    shownMinutes = shownMinutes.length == 1 ? "0$shownMinutes" : shownMinutes;
    shownSeconds = shownSeconds.length == 1 ? "0$shownSeconds" : shownSeconds;

    return "$isNegative$shownHours:$shownMinutes:$shownSeconds";
  }

  void createNewFile({newFileName, newFileContent}) {
    var newFile = new File("${timeLogsDirectory.path}/$newFileName");
    newFile.createSync();
    newFile.writeAsStringSync(newFileContent);
  }

  void clearOldLogs() {
//    createNewFile(newFileName: "2020-02-02_log.txt", newFileContent: "54123,false/54279,false/54372,false/56335,false/56437,false/56449,false/56489,false/56518,false/56714,false/");
    var logDirectoryFiles = timeLogsDirectory.listSync();
    for (var i = 0; i < logDirectoryFiles.length; i++) {
      if (timeLog.path != logDirectoryFiles[i].path) {
        var currentFile = File(logDirectoryFiles[i].path);
        var currentFileContent = currentFile.readAsStringSync();
        var currentFileContentSplit = currentFileContent.split('/');
        var latestWasBuilding = currentFileContentSplit[currentFileContentSplit.length - 2].split(",")[1];
        currentFileContent += "86400,$latestWasBuilding/";
        currentFile.writeAsStringSync(currentFileContent);

        var totalSeconds = retrieveTrackedTime(currentFile);
        var timeSum = convertSecondsToHourFormat(totalSeconds);
        var directoryNameList = logDirectoryFiles[i].path.split('/');

        var newContent = "${directoryNameList[directoryNameList.length-1]};$timeSum/";
        var calendarContent = calendar.readAsStringSync();
        calendarContent += newContent;
        calendar.writeAsStringSync(calendarContent);
        currentFile.deleteSync();
      }
    }
  }
}
