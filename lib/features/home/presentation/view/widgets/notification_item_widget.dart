import 'package:flutter/material.dart';
import 'package:smart_sugar/features/home/domain/notification_entity.dart';

import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({
    super.key,
    required this.notification,
  });

  final NotificationEntity notification;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      color: AppColor.whiteColor,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
          Radius.circular(12),
        )),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Icon(
                Icons.medical_services_rounded,
                color: AppColor.primaryColor,
                size: 40,
             ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: Styles.regular16
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      notification.body,
                      style: Styles.regular13
                          .copyWith(color: AppColor.lightGrayColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          notification.time,
                          style: Styles.regular13
                              .copyWith(color: AppColor.lightGrayColor),
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          notification.day,
                          style: Styles.regular13
                              .copyWith(color: AppColor.lightGrayColor),
                          textAlign: TextAlign.end,
                          maxLines: 1,
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
