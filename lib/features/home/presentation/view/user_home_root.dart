import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_sugar/features/centers/presentation/views/sugar_centers_view.dart';
import 'package:smart_sugar/features/chat/presentation/views/ai_chat_view.dart';
import 'package:smart_sugar/features/profile/presentation/views/profile_view.dart';

import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../diet/presentation/view/diet_view.dart';
import 'home_view.dart';

class UserHomeRoot extends StatefulWidget {
  const UserHomeRoot({super.key});
  static const routeName = 'rootHome';
  @override
  State<UserHomeRoot> createState() => _UserHomeRootState();
}

class _UserHomeRootState extends State<UserHomeRoot> {
  int mCurrentIndex = 0;
  int mCounter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomeView(),
        DietView(),
        AiChatView(),
        SugarCentersView(),
        ProfileView(),
      ][mCurrentIndex],
      bottomNavigationBar: Container(
        height: 60,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            )),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            enableFeedback: false,
            selectedLabelStyle: Styles.tabsSelectedTextStyle,
            unselectedLabelStyle: Styles.tabsUnSelectedTextStyle,
            backgroundColor: Colors.transparent,
            currentIndex: mCurrentIndex,
            useLegacyColorScheme: false,
            onTap: (index) {
              mCurrentIndex = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AssetsData.homeIcon,
                    fit: BoxFit.scaleDown,
                  ),
                  activeIcon: SvgPicture.asset(
                    AssetsData.homeIcon,
                    colorFilter:
                        ColorFilter.mode(AppColor.orangeColor, BlendMode.srcIn),
                    fit: BoxFit.scaleDown,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AssetsData.dietIcon,
                    fit: BoxFit.scaleDown,
                  ),
                  activeIcon: SvgPicture.asset(
                    AssetsData.dietIcon,
                    colorFilter:
                        ColorFilter.mode(AppColor.orangeColor, BlendMode.srcIn),
                    fit: BoxFit.scaleDown,
                  ),
                  label: 'Diet'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AssetsData.chatIcon,
                    colorFilter:
                    ColorFilter.mode(AppColor.lightGrayColor, BlendMode.srcIn),
                  ),
                  activeIcon: SvgPicture.asset(
                    AssetsData.chatIcon,
                    colorFilter:
                        ColorFilter.mode(AppColor.orangeColor, BlendMode.srcIn),
                  ),
                  label: 'AI'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AssetsData.centerIcon,
                    fit: BoxFit.scaleDown,
                  ),
                  activeIcon: SvgPicture.asset(
                    AssetsData.centerIcon,
                    colorFilter:
                        ColorFilter.mode(AppColor.orangeColor, BlendMode.srcIn),
                    fit: BoxFit.scaleDown,
                  ),
                  label: 'Center'),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetsData.profileIcon,
                  fit: BoxFit.scaleDown,
                ),
                activeIcon: SvgPicture.asset(
                  AssetsData.profileIcon,
                  colorFilter:
                      ColorFilter.mode(AppColor.orangeColor, BlendMode.srcIn),
                  fit: BoxFit.scaleDown,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
