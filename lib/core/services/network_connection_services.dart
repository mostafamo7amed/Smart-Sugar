import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_manager/app_colors.dart';
import '../utils/app_manager/app_styles.dart';

class NetworkConnectionController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(
      (event) {
        _updateConnectionStatus(event.first);
      },
    );
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      Get.rawSnackbar(
        backgroundColor: AppColor.redColor,
        isDismissible: false,
        messageText: Text(
          "No internet connection",
          style: Styles.regular16.copyWith(color: AppColor.whiteColor),),
        icon: Icon(
          Icons.wifi_off,
          color: AppColor.whiteColor,
        ),
        duration: const Duration(days: 1),
        animationDuration: const Duration(milliseconds: 300),
        reverseAnimationCurve: Curves.easeOutBack,
        snackStyle: SnackStyle.FLOATING,
      );
    } else {
      Get.rawSnackbar(
        backgroundColor: AppColor.primaryColor,
        isDismissible: false,
        messageText: Text(
          "You are back online",
          style: Styles.regular16.copyWith(color: AppColor.whiteColor),),
        icon: Icon(
          Icons.wifi,
          color: AppColor.whiteColor,
        ),
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 300),
        reverseAnimationCurve: Curves.easeOutBack,
        snackStyle: SnackStyle.FLOATING,
      );
      if (Get.isSnackbarOpen == true) {
        Get.closeAllSnackbars();
      }
    }
  }
}
