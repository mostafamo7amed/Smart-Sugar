import 'package:flutter/material.dart';

import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

class CustomTabItem extends StatelessWidget {
  const CustomTabItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.index,
    required this.onTap,
  });
  final String title;
  final int isSelected;
  final int index;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color:
                isSelected == index ? AppColor.blueColor : AppColor.fillColor,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Styles.semiBold16.copyWith(
                color: isSelected == index
                    ? AppColor.whiteColor
                    : AppColor.lightGrayColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
