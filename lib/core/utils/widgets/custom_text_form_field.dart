import 'package:flutter/material.dart';

import '../app_manager/app_colors.dart';
import '../app_manager/app_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key, this.suffixIcon, this.hintText, this.validator, this.keyboardType, this.onSaved,  this.obscureText = false});
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;

  final void Function(String?)? onSaved;

  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        obscureText: obscureText,
        onSaved: onSaved,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: Styles.bold13.copyWith(color: AppColor.lightGrayColor),
          fillColor: AppColor.fillColor,
          filled: true,
          border: buildOutlineInputBorder(),
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 1,
        color: AppColor.lightGrayColor,
      ),
    );
  }
}
