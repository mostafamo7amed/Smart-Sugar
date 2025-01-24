
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

class AdminPanelItem extends StatelessWidget {
  const AdminPanelItem({
    super.key, required this.title, required this.icon, this.onTap, required this.color,
  });
  final String title;
  final String icon;
  final void Function()? onTap;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.whiteColor,
          ),
          child: Center(
            child: Row(
              children: [
                SvgPicture.asset(icon,
                    height: 25,
                    colorFilter: ColorFilter.mode(
                        color, BlendMode.srcIn)),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: Styles.bold16,
                ),
                Spacer(),
                Icon(
                  size: 18,
                  Icons.arrow_forward_ios,
                  color: color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
