
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

class UserActivityWidget extends StatelessWidget {
  const UserActivityWidget({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
  });
  final String title;
  final String value;
  final String unit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title.toUpperCase(),
          style: Styles.regular13.copyWith(color: AppColor.lightGrayColor),
        ),
        Text.rich(
          TextSpan(
            text: value,
            style: Styles.bold19,
            children: [
              TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: unit,
                style:
                Styles.regular13.copyWith(color: AppColor.lightGrayColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
