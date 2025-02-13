import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';

import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/app_manager/app_styles.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});
  static const routeName = 'aboutUsView';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(context, title: 'About Us', showProfile: false),
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * .16),
                  padding: const EdgeInsets.all(10.0),
                  width: size.width / 2.4,
                  height: size.width / 2.4,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      image: DecorationImage(
                          image: AssetImage(
                            AssetsData.appLogo,
                          ),
                          fit: BoxFit.contain)),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Version 1.0.0",
                  style:
                      Styles.regular16.copyWith(color: AppColor.lightGrayColor),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Smart Sugar, a user-friendly mobile application integrated with AI to simplify diabetes management. The application enables users to track glucose levels, receive personalized health recommendations, manage medication intake, and access emergency assistance.',
                    style: Styles.medium15,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ));
  }
}
