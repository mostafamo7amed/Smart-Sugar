import 'package:flutter/material.dart';
import '../utils/app_manager/app_colors.dart';

Future<DateTime?> pickTime(BuildContext context) async {
  TimeOfDay initialTime = TimeOfDay.now();
  TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              secondary: AppColor.blackColor,
              onSecondary: AppColor.whiteColor,
              brightness: Brightness.light,
              primary: AppColor.blackColor,
              onPrimary: AppColor.whiteColor,
            ),
            dialogBackgroundColor:
                AppColor.whiteColor, // Background color of the date picker
          ),
          child: child!,
        );
      });
  DateTime? formattedPickedTime;
  if (pickedTime != null) {
    formattedPickedTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, pickedTime.hour, pickedTime.minute);
  }
  return formattedPickedTime;
}
