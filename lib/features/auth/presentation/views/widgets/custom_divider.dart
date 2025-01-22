import 'package:flutter/material.dart';

import '../../../../../core/utils/app_manager/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 4),
      child: Divider(
        height: 1,
        color: AppColor.lightGrayColor,
      ),
    );
  }
}
