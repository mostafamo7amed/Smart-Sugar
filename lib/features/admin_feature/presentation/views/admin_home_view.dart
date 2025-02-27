import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/core/services/app_references.dart';
import 'package:smart_sugar/core/utils/widgets/home_app_bar.dart';
import 'package:smart_sugar/features/admin_feature/presentation/views/manage_articles_view.dart';
import 'package:smart_sugar/features/admin_feature/presentation/views/manage_sugar_center_view.dart';
import 'package:smart_sugar/features/admin_feature/presentation/views/refresh_api_view.dart';
import 'package:smart_sugar/features/admin_feature/presentation/views/widgets/admin_panel_item.dart';
import 'package:smart_sugar/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:smart_sugar/features/auth/presentation/views/login_view.dart';

import '../../../../constants.dart';
import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/widgets/custom_dialog.dart';
import 'manage_emergency_number_view.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});
  static const routeName = 'adminHomeView';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {
    if (state is LoginLogoutState) {
      Navigator.pushNamedAndRemoveUntil(context, LoginView.routeName, (route) => false);
    }
  },
  builder: (context, state) {
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
                  icon: AssetsData.articleImage,
                  onTap: () {
                    Navigator.pushNamed(context, ManageArticlesView.routeName);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                AdminPanelItem(
                  title: 'Emergency Numbers',
                  color: AppColor.primaryColor,
                  icon: AssetsData.phoneImage,
                  onTap: () {
                    Navigator.pushNamed(context, ManageEmergencyNumberView.routeName);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                AdminPanelItem(
                  title: 'Refresh Api',
                  color: AppColor.pinkColor,
                  icon: AssetsData.infoImage,
                  onTap: () {
                    Navigator.pushNamed(context, RefreshApiView.routeName);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                AdminPanelItem(
                  title: 'Logout',
                  color: AppColor.redColor,
                  icon: AssetsData.logoutImage,
                  onTap: () {
                    customDialog(
                      context: context,
                      message: 'Are you sure you want logout?',
                      onConfirm: () {
                        AppReference.removeData(key: userIdKey);
                        AppReference.removeData(key: authKey);
                        LoginCubit.get(context).logout();
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ],
            ),
            Spacer(flex: 5,),
          ],
        ),
      ),
    );
  },
);
  }
}
