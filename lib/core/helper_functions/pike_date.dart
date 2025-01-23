import 'package:flutter/material.dart';

import '../utils/app_manager/app_colors.dart';

Future<DateTime?> pickDate(BuildContext context) async {
  DateTime? date = DateTime(1900);
  date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
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
  return date;
}