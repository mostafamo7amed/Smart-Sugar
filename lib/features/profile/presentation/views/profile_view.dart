import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_sugar/core/utils/app_manager/app_assets.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/features/auth/presentation/views/login_view.dart';
import 'package:smart_sugar/features/profile/presentation/views/glucose_report_view.dart';
import 'package:smart_sugar/features/profile/presentation/views/medication_reminder_view.dart';
import 'package:smart_sugar/features/profile/presentation/views/widgets/custom_profile_field.dart';
import 'package:smart_sugar/features/profile/presentation/views/widgets/profile_title_widget.dart';

import '../../../../core/utils/app_manager/app_colors.dart';
import 'about_us_view.dart';
import 'edit_profile_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  static const routeName = 'profileView';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context,
          title: 'My Profile', showBackButton: false, showProfile: false),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, EditProfileView.routeName);
              },
              child: ProfileTitleWidget(
                  size: size, name: "John Doe", image: AssetsData.profileIcon),
            ),
            CustomProfileField(
              icon: SvgPicture.asset(
                AssetsData.reportImage,
                colorFilter:
                    ColorFilter.mode(AppColor.blackColor, BlendMode.srcIn),
              ),
              onTap: () {
                Navigator.pushNamed(context, GlucoseReportView.routeName);
              },
              title: 'Glucose Report',
              arrow: Icon(
                size: 18,
                Icons.arrow_forward_ios_outlined,
                color: AppColor.lightGrayColor,
              ),
            ),
            CustomProfileField(
              icon: SvgPicture.asset(
                AssetsData.notificationIcon,
                colorFilter:
                ColorFilter.mode(AppColor.blackColor, BlendMode.srcIn),
              ),
              onTap: () {
                Navigator.pushNamed(context, MedicationReminderView.routeName);
              },
              title: 'Medication Reminders',
              arrow: Icon(
                size: 18,
                Icons.arrow_forward_ios_outlined,
                color: AppColor.lightGrayColor,
              ),
            ),
            CustomProfileField(
              icon: SvgPicture.asset(
                colorFilter:
                    ColorFilter.mode(AppColor.blackColor, BlendMode.srcIn),
                AssetsData.notificationIcon,
              ),
              onTap: () {},
              title: 'Notifications',
              arrow: SizedBox(
                height: 30,
                child: Switch(
                  activeColor: AppColor.primaryColor,
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ),
            ),
            CustomProfileField(
              icon: SvgPicture.asset(
                AssetsData.infoImage,
              ),
              onTap: () {
                Navigator.pushNamed(context, AboutUsView.routeName);
              },
              title: 'About Us',
              arrow: Icon(
                size: 18,
                Icons.arrow_forward_ios_outlined,
                color: AppColor.lightGrayColor,
              ),
            ),
            CustomProfileField(
              icon: SvgPicture.asset(
                AssetsData.logoutImage,
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, LoginView.routeName);
              },
              title: 'Logout',
              arrow: Icon(
                size: 18,
                Icons.arrow_forward_ios_outlined,
                color: AppColor.lightGrayColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
