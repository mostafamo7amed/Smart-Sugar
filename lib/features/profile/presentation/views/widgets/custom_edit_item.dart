import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/widgets/custom_text_form_field.dart';

import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

class CustomEditItem extends StatelessWidget {
  const CustomEditItem({
    super.key,
    this.validation,
    required this.controller,
    required this.title, this.suffixIc, required this.textInputType,this.prefixWidget, this.isEnabled
  });

  final TextEditingController controller;
  final String title;
  final Widget? suffixIc;
  final Widget? prefixWidget;
  final TextInputType textInputType;
  final String? Function(String?)? validation;
  final bool? isEnabled;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.regular13
                .copyWith(color: AppColor.lightGrayColor),
          ),
          const SizedBox(height: 7,),
          CustomTextFormField(
            isEnabled: isEnabled,
            controller: controller,
            keyboardType: textInputType,
            validator: validation,
            suffixIcon:  suffixIc,
            prefixIcon: prefixWidget,
          ),
        ],
      ),
    );
  }
}