import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/widgets/home_app_bar.dart';
import 'package:smart_sugar/features/admin_feature/presentation/views/manage_sugar_center_view.dart';
import 'package:smart_sugar/features/admin_feature/presentation/views/widgets/admin_panel_item.dart';

import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/app_manager/app_styles.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});
  static const routeName = 'adminHomeView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context, showNotification: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start ,
          children: [
           SizedBox(height: 30,),
            Text(
              'Welcome, Admin',
              style: Styles.bold23,

            ),
            Text(
              'admin123@gmail.com',
              style: Styles.regular16.copyWith(color: AppColor.lightGrayColor),
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Admin Panel', style: Styles.bold19),
                Text(
                  'You can manage sugar measurement centers, medical articles and emergency numbers.',
                  style: Styles.regular13.copyWith(color: AppColor.lightGrayColor),
                ),
                SizedBox(
                  height: 20,
                ),
                AdminPanelItem(
                  title: 'Sugar Centers',
                  color: AppColor.blueColor,
                  icon: AssetsData.centerIcon,
                  onTap: () {
                    Navigator.pushNamed(context, ManageSugarCenterView.routeName);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                AdminPanelItem(
                  title: 'Medical Articles',
                  color: AppColor.orangeColor,
                  icon: AssetsData.dietIcon,
                  onTap: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                AdminPanelItem(
                  title: 'Emergency Numbers',
                  color: AppColor.primaryColor,
                  icon: AssetsData.ageIcon,
                  onTap: () {},
                ),
              ],
            ),
            Spacer(flex: 5,),
          ],
        ),
      ),
    );
  }
}
