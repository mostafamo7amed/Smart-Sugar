import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/app_manager/app_assets.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/features/auth/presentation/views/login_view.dart';
import 'package:smart_sugar/features/profile/presentation/views/articles_view.dart';
import 'package:smart_sugar/features/profile/presentation/views/glucose_report_view.dart';
import 'package:smart_sugar/features/profile/presentation/views/widgets/custom_profile_field.dart';
import 'package:smart_sugar/features/profile/presentation/views/widgets/profile_title_widget.dart';

import '../../../../core/utils/app_manager/app_colors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, title: 'Profile', showBackButton: false),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: ProfileTitleWidget(
                  size: size, name: "John Doe", image: AssetsData.chatGptIcon),
            ),
            CustomProfileField(
              onTap: () {
                Navigator.pushNamed(context, GlucoseReportView.routeName);
              },
              title: 'Glucose Report',
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColor.lightGrayColor,
              ),
            ),
            CustomProfileField(
              onTap: () {
                Navigator.pushNamed(context, MedicalArticlesView.routeName);
              },
              title: 'Medical Articles',
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColor.lightGrayColor,
              ),
            ),
            CustomProfileField(
              onTap: () {},
              title: 'Notifications',
              icon: SizedBox(
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
              onTap: () {},
              title: 'Help & Support',
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColor.lightGrayColor,
              ),
            ),
            CustomProfileField(
              onTap: () {},
              title: 'About Us',
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColor.lightGrayColor,
              ),
            ),
            CustomProfileField(
              onTap: () {
                Navigator.pushReplacementNamed(context, LoginView.routeName);
              },
              title: 'Logout',
              icon: Image.asset(
                AssetsData.exitIcon,
                height: 24,
                color: AppColor.lightGrayColor,
                width: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
