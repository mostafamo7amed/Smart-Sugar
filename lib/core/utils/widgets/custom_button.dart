import 'package:flutter/material.dart';
import '../app_manager/app_colors.dart';
import '../app_manager/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, this.text, required this.onPressed, this.isLoading = false});
  final String? text;
  final void Function()? onPressed;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * .93,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            backgroundColor: AppColor.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        child: !isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text ?? '',
                    style:Styles.bold16.copyWith(color: AppColor.whiteColor),
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
    );
  }
}
