import 'package:flutter/material.dart';

import '../../../../../core/helper_functions/current_time.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

Widget buildSenderMessage(context) {
  String senderTime = currentTime();

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * .7,
          ),
          decoration: BoxDecoration(
            color: AppColor.blueColor.withValues(alpha: .35),
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomStart: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'What type of exercises can I do to help lower my blood sugar ?',
                  style:
                  Styles.regular16.copyWith(color: AppColor.blackColor),
                ),
              ),
              Text(
                senderTime,
                style: Styles.regular11.copyWith(color: AppColor.lightGrayColor),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}