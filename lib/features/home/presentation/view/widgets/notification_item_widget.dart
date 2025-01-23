
import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/extensions.dart';

import '../../../../../core/utils/app_manager/app_assets.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';
import '../../../../../core/utils/widgets/cached_image.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      color: AppColor.whiteColor,
      child: Container(
        width:MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            )),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cachedImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQI308Gg7fgBFR5VSmruzyBVJCuzfnLedp53A&s',AssetsData.placeHolder,
                  fit: BoxFit.fill,
                  width: size.width / 4.3,
                  height: size.width / 4.3)
                  .cornerRadiusWithClipRRect(12),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'It’s time to take glucose measurement',
                      style: Styles.regular16
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      style: Styles.regular13
                          .copyWith(color: AppColor.lightGrayColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          'Yesterday',
                          style: Styles.regular13
                              .copyWith(color: AppColor.lightGrayColor),
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          height: 7,
                          width: 7,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.blackColor,
                          ),
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