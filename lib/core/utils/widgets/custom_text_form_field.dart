import 'package:flutter/material.dart';

import '../app_manager/app_colors.dart';
import '../app_manager/app_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key, this.suffixIcon,this.prefixIcon, this.hintText, this.validator, this.keyboardType, this.onSaved,  this.obscureText = false});
  final Widget? suffixIcon,prefixIcon;
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
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: Styles.regular13.copyWith(color: AppColor.lightGrayColor),
          fillColor: AppColor.whiteColor,
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
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: .5,
        color: AppColor.lightGrayColor,
      ),
    );
  }
}
