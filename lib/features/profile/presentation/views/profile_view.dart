import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_sugar/core/services/app_references.dart';
import 'package:smart_sugar/core/utils/app_manager/app_assets.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:smart_sugar/features/auth/presentation/views/login_view.dart';
import 'package:smart_sugar/features/home/presentation/manager/user_cubit.dart';
import 'package:smart_sugar/features/profile/presentation/views/glucose_report_view.dart';
import 'package:smart_sugar/features/profile/presentation/views/medication_reminder_view.dart';
import 'package:smart_sugar/features/profile/presentation/views/widgets/custom_profile_field.dart';
import 'package:smart_sugar/features/profile/presentation/views/widgets/profile_title_widget.dart';

import '../../../../constants.dart';
import '../../../../core/helper_functions/request_notification_permission.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/widgets/custom_dialog.dart';
import 'about_us_view.dart';
import 'edit_profile_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, this.showBackButton = false});
  final bool? showBackButton;

  static const routeName = 'profileView';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool? isSwitched;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context,
          title: 'My Profile',
          showBackButton: widget.showBackButton ?? false,
          showProfile: false),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLogoutState) {
            Navigator.pushNamedAndRemoveUntil(
                context, LoginView.routeName, (route) => false);
          }
        },
        builder: (context, state) {
          return BlocConsumer<UserCubit, UserState>(
            listener: (context, userState) {
              if(userState is UpdateNotificationStatusSuccessState){
                UserCubit.get(context).getUser(AppReference.getData(key: userIdKey));
              }
            },
            builder: (context, userState) {
              var cubit = UserCubit.get(context);
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, EditProfileView.routeName);
                      },
                      child: ProfileTitleWidget(
                          size: size,
                          name: cubit.userEntity?.name ?? '',
                          image: AssetsData.profileIcon),
                    ),
                    CustomProfileField(
                      icon: SvgPicture.asset(
                        AssetsData.reportImage,
                        colorFilter: ColorFilter.mode(
                            AppColor.blackColor, BlendMode.srcIn),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, GlucoseReportView.routeName);
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
                        colorFilter: ColorFilter.mode(
                            AppColor.blackColor, BlendMode.srcIn),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                            context, MedicationReminderView.routeName);
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
                        colorFilter: ColorFilter.mode(
                            AppColor.blackColor, BlendMode.srcIn),
                        AssetsData.notificationIcon,
                      ),
                      onTap: () {},
                      title: 'Notifications',
                      arrow: SizedBox(
                        height: 30,
                        child: Switch(
                          activeColor: AppColor.primaryColor,
                          value: cubit.userEntity?.fcmToken ?? false,
                          onChanged: (value) {
                                requestNotificationPermission();
                            cubit.updateNotificationStatus(
                                AppReference.getData(key: userIdKey), value);
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
                      title: 'Logout',
                      arrow: Icon(
                        size: 18,
                        Icons.arrow_forward_ios_outlined,
                        color: AppColor.lightGrayColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
