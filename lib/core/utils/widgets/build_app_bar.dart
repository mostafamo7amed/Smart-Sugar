import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../features/profile/presentation/views/profile_view.dart';
import '../app_manager/app_assets.dart';
import '../app_manager/app_colors.dart';
import '../app_manager/app_styles.dart';

AppBar buildAppBar(context,
    {required String title,
    bool showBackButton = true,
    bool showProfile = true,
    bool isProfile = false,
      void Function()? onProfileEdit
    }) {
  return AppBar(
    toolbarHeight: 70,
    shadowColor: AppColor.lightGrayColor,
    surfaceTintColor: Colors.transparent,
    backgroundColor: Colors.white,
    leading: Visibility(
      visible: showBackButton,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios_new,
        ),
      ),
    ),
    centerTitle: false,
    titleSpacing: 0,
    title: Text(
      title,
      textAlign: TextAlign.center,
      style: Styles.bold19,
    ),
    actions: [
      Visibility(
        visible: showProfile,
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColor.fillColor),
              shape: WidgetStateProperty.all(const CircleBorder()),
            ),
            icon: SvgPicture.asset(
              AssetsData.profileIcon,
              height: 25,
              width: 25,
              colorFilter:
                  ColorFilter.mode(AppColor.lightGrayColor, BlendMode.srcIn),
            ),
            onPressed: () {
              Navigator.pushNamed(context, ProfileView.routeName,arguments: true);
            },
          ),
        ),
      ),
      Visibility(
        visible: isProfile,
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColor.fillColor),
              shape: WidgetStateProperty.all(const CircleBorder()),
            ),
            icon: Icon(Icons.edit_outlined, color: AppColor.lightGrayColor),
            onPressed: onProfileEdit,
          ),
        ),
      ),
    ],
  );
}
