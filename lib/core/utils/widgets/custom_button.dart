import 'package:flutter/material.dart';
import '../app_manager/app_colors.dart';
import '../app_manager/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, this.text, required this.onPressed, this.isLoading = false,this.width, this.height, this.color});
  final String? text;
  final void Function()? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: height ?? 50,
        width: width ?? MediaQuery.of(context).size.width * .93,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              backgroundColor: color ?? AppColor.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          child: !isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text ?? '',
                      style: Styles.bold16.copyWith(color: AppColor.whiteColor),
                    ),
                  ],
                )
              : Center(
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
