import 'package:permission_handler/permission_handler.dart';

Future<bool> requestNotificationPermission() async {
  // Check if the permission is already granted
  PermissionStatus status = await Permission.notification.status;

  if (status.isGranted) {
    return true;
  }

  // If not granted, request the permission
  if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
    status = await Permission.notification.request();
  }

  // Return true if granted, false otherwise
  return status.isGranted;
}
