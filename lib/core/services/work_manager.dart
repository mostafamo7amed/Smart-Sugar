import 'dart:developer';

import 'package:smart_sugar/core/services/local_notification_services.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerServices {
  static Future<void> init() async {
    log('init');
    await Workmanager().initialize(
        reminderTask,
        isInDebugMode: true);
    registerReminder('1', 'from work manager');
  }
  static Future<void> registerReminder(String id, String title,) async {
    log('registerReminder');
    await Workmanager().registerPeriodicTask(id, title,
      frequency: const Duration(minutes: 15),
    );
  }

  static Future<void> cancelReminder(String id,) async {
    await Workmanager().cancelByUniqueName(id);
  }

}
@pragma('vm:entry-point')
reminderTask() {
  Workmanager().executeTask((task, inputData) async {
    log('reminderTask');
    LocalNotificationServices.scheduleNotification(1, 'from work manager', 'from work manager', DateTime.now());
    return Future.value(true);
  });
}