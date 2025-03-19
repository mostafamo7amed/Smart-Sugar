import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:timezone/data/latest.dart' as tz;

import '../../constants.dart';

class LocalNotificationServices {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static onNotificationTap(NotificationResponse notificationResponse) {

  }
  static initialize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap,
        onDidReceiveNotificationResponse: onNotificationTap,
    );
    flutterLocalNotificationsPlugin.getActiveNotifications();
  }

  static requestPermissions() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
          critical: true,
        );
  }

  static cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static scheduleNotification(
      int id, String title, String body, DateTime dateTime) async {
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    log('current time zone: $currentTimeZone');
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    tz.Location currentLocation = tz.getLocation(currentTimeZone);
    tz.TZDateTime scheduleTime = tz.TZDateTime(
        currentLocation,
        dateTime.year,
        dateTime.month,
        dateTime.day,
        dateTime.hour,
        dateTime.minute,
        dateTime.second
    );
    log('local notification time: ${tz.local}');
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduleTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(channelId, channelName,
            importance: Importance.high, priority: Priority.high),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
