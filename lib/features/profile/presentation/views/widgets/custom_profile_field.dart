import 'package:flutter/material.dart';

import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

class CustomProfileField extends StatelessWidget {
  const CustomProfileField({
    super.key,
    required this.title,
    required this.icon, this.onTap,
  });

  final String title;
  final Widget icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        width: size.width,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(children: [
          Text(
            title,
            style: Styles.bold16,
          ),
          const Spacer(),
          icon,
        ]),
      ),
    );
  }
}