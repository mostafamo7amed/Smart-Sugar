import 'package:flutter/material.dart';
import 'package:smart_sugar/features/chat/domain/message_entity.dart';

import '../../../../../core/utils/app_manager/app_assets.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';
import '../../../../../core/utils/widgets/animated_decorated_text.dart';

Widget buildReceiverMessage(context, MessageModel message) {

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
                child: AnimatedDecoratedText(
                  message.text.toString(),
                )
              ),
              Text(
                message.dateTime.toString(),
                style: Styles.regular11.copyWith(color: AppColor.grayColor.withValues(alpha: .8)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}