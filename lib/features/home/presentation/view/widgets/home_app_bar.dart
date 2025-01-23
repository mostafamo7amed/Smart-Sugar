import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_sugar/features/home/presentation/view/notification_view.dart';

import '../../../../../core/utils/app_manager/app_assets.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

AppBar homeAppBar(context,) {
  return AppBar(
    backgroundColor: AppColor.backgroundColor,
    leadingWidth: 75,
    titleSpacing: 0,
    leading: Image.asset(AssetsData.appIcon,),
    centerTitle: false,
    title: Text(
      'smart sugar'.toUpperCase(),
      textAlign: TextAlign.start,
      style: Styles.bold19.copyWith(color: AppColor.blueColor),
    ),
    actions: [
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, NotificationView.routeName),
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: SvgPicture.asset(
            AssetsData.notificationIcon,
            height: 30,
            colorFilter: ColorFilter.mode(  AppColor.grayColor, BlendMode.srcIn),
          ),
        ),
      ),
    ],
  );
}