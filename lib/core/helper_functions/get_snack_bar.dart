import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../utils/app_manager/app_colors.dart';
import '../utils/app_manager/app_styles.dart';

getSnackBar(String message) {
  Get.rawSnackbar(
    messageText: Text(
      message,
      style: Styles.regular16.copyWith(color: AppColor.whiteColor),),
    duration: const Duration(seconds: 2),
    animationDuration: const Duration(milliseconds: 300),
    reverseAnimationCurve: Curves.easeOutBack,
    snackStyle: SnackStyle.FLOATING,
  );
}