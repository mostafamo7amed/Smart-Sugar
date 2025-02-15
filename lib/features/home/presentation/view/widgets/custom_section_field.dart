import 'package:flutter/material.dart';

import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

class CustomSectionField extends StatelessWidget {
  const CustomSectionField({super.key, required this.title, this.onTap});
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Styles.semiBold16,
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'See All',
            style: Styles.semiBold16.copyWith(
                color: AppColor.orangeColor,
                decoration: TextDecoration.underline,
                decorationColor: AppColor.orangeColor),
          ),
        ),
      ],
    );
  }
}
