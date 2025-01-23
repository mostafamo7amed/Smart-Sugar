import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/notification_item_widget.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});
  static const String routeName = "notificationView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Notifications'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              //Navigator.pop(context);
            },
            child: NotificationItemWidget(),
          ),
          itemCount: 3,
        ),
      ),
    );
  }
}
