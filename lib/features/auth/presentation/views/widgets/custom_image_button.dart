import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_sugar/core/utils/app_manager/app_colors.dart';

class CustomImageButton extends StatelessWidget {
  const CustomImageButton({
    super.key,
    required this.onTap,
    required this.imagePath,
  });
  final void Function()? onTap;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: AppColor.fillColor,
            shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(imagePath,fit: BoxFit.scaleDown,),
      ),
    );
  }
}