
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_sugar/core/utils/extensions.dart';

import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

class ProfileTitleWidget extends StatelessWidget {
  const ProfileTitleWidget({
    super.key,
    required this.size, required this.name, required this.image,
  });

  final Size size;
  final String name,image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      width: size.width,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 5,),
              CircleAvatar(
                backgroundColor: AppColor.fillColor,
                radius: 38,
               /* child: cachedImage(
                    image,
                    AssetsData.placeHolder).cornerRadiusWithClipRRect(38),*/
                child: SvgPicture.asset(image).cornerRadiusWithClipRRect(38),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Styles.bold23,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "View  profile details",
                      style: Styles.regular13
                          .copyWith(color: AppColor.lightGrayColor),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
