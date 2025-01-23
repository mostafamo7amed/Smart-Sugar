import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/app_manager/app_assets.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

Widget buildReceiverMessage(context) {
  String formattedTime = DateFormat('kk:mm a').format(DateTime.now());
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 5,),
        CircleAvatar(
          radius: 18,
          backgroundColor: AppColor.fillColor,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              AssetsData.chatGptIcon,),
          ),
        ),
        SizedBox(width: 5,),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * .7,
          ),
          decoration: BoxDecoration(
            color:AppColor.lightGrayColor.withValues(alpha: .2),
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'Great question! Regular physical activity helps improve blood sugar control. Consider moderate exercises like brisk walking, cycling, or light jogging for about 30 minutes a day, 5 days a week. Resistance exercises, like lifting weights or using resistance bands, are also beneficial. Remember, start gradually if you’re new to exercise and always check with your healthcare provider before beginning a new routine!',
                  style: Styles.regular16.copyWith(color: AppColor.blackColor),
                ),
              ),
              Text(
                formattedTime,
                style: Styles.regular11.copyWith(color: AppColor.grayColor.withValues(alpha: .8)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}