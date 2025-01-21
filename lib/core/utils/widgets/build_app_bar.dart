import 'package:flutter/material.dart';
import '../app_manager/app_styles.dart';

AppBar buildAppBar(context,
    {required String title,
      bool showBackButton = true,
      bool showNotification = true}) {
  return AppBar(
    backgroundColor: Colors.white,
    leading: Visibility(
      visible: showBackButton,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios_new,
        ),
      ),
    ),
    centerTitle: true,
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: Styles.bold19,
    ),
  );
}