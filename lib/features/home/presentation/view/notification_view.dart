import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/features/home/presentation/manager/user_cubit.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/notification_item_widget.dart';

import '../../../../constants.dart';
import '../../../../core/services/app_references.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});
  static const String routeName = "notificationView";

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    super.initState();
    UserCubit.get(context)
        .getNotifications(AppReference.getData(key: userIdKey));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return CustomProgressHud(
          isLoading: state is GetNotificationsLoadingState,
          child: Scaffold(
            appBar: buildAppBar(context, title: 'Notifications'),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: cubit.notifications.isEmpty
                  ? const Center(child: Text('No Notifications'))
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                        },
                        child: NotificationItemWidget(
                          notification: cubit.notifications[index],
                        ),
                      ),
                      itemCount: cubit.notifications.length,
                    ),
            ),
          ),
        );
      },
    );
  }
}
