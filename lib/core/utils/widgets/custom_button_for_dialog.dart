import 'package:flutter/material.dart';

import '../app_manager/app_styles.dart';


class CustomTextButtonForDialog extends StatelessWidget {
  const CustomTextButtonForDialog({
    super.key,
    required this.mainTitle,
    required this.buttonBackgroundColor,
    required this.onTaped,
    this.textColor,
  });
  final String mainTitle;
  final Color? buttonBackgroundColor;
  final void Function()? onTaped;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTaped,
        style: TextButton.styleFrom(
            backgroundColor: buttonBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // <-- Radius
            )),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: Text(mainTitle,
              textAlign: TextAlign.center,
              style: Styles.regular16.copyWith(
                  fontWeight: FontWeight.w600, color: textColor)),
        ));
  }
}