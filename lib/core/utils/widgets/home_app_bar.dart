import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_sugar/features/home/presentation/view/notification_view.dart';

import '../app_manager/app_assets.dart';
import '../app_manager/app_colors.dart';
import '../app_manager/app_styles.dart';

AppBar homeAppBar(context, {bool showNotification = true}) {
  return AppBar(
    shadowColor: AppColor.lightGrayColor,
    surfaceTintColor: Colors.transparent,
    toolbarHeight: 80,
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
      Visibility(
        visible: showNotification,
        child: GestureDetector(
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
      ),
    ],
  );
}