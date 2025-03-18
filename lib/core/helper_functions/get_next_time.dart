import 'dart:developer';

import 'package:intl/intl.dart';

DateTime getNextScheduledDateTime(String timeStr, String dayStr) {
  DateTime now = DateTime.now();
  DateFormat timeFormat = DateFormat("hh:mm a");
  DateTime time = timeFormat.parse(timeStr);
  int hours = time.hour;
  int minutes = time.minute;
  Map<String, int> weekDays = {
    "Mon": DateTime.monday,
    "Tue": DateTime.tuesday,
    "Wed": DateTime.wednesday,
    "Thu": DateTime.thursday,
    "Fri": DateTime.friday,
    "Sat": DateTime.saturday,
    "Sun": DateTime.sunday,
  };
  int targetWeekday = weekDays[dayStr]!;

  int todayWeekday = now.weekday;
  log('todayWeekday: $todayWeekday');
  DateTime scheduledDate = DateTime(now.year, now.month, now.day, hours, minutes);

  if(targetWeekday == todayWeekday && scheduledDate.isAfter(now)) {
    scheduledDate = scheduledDate;
  }
  else if (targetWeekday == todayWeekday && scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(Duration(days: 7));
  }
  else if (targetWeekday > todayWeekday) {
    scheduledDate = scheduledDate.add(Duration(days: targetWeekday - todayWeekday));
  }
  else {
    scheduledDate = scheduledDate.add(Duration(days: 7 - (todayWeekday - targetWeekday)));
  }

  return scheduledDate;
}
