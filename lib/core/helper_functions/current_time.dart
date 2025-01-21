import 'package:intl/intl.dart';

String currentTime() {
  var now = DateTime.now();
  var formatterTime = DateFormat('kk:mm a');
  String actualTime = formatterTime.format(now);
  return actualTime;
}