import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:smart_sugar/core/utils/widgets/cached_image.dart';
import 'package:smart_sugar/core/utils/widgets/custom_button.dart';
import 'package:smart_sugar/features/centers/domain/entities/sugar_center_entity.dart';

import '../../../../core/helper_functions/url_lancher.dart';
import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';

class SugarDetailsView extends StatelessWidget {
  const SugarDetailsView({super.key, required this.sugarCenter});

  static const String routeName = 'SugarDetailsView';
  final SugarCenterEntity sugarCenter;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, title: 'Sugar Details'),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(25),
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.lightGrayColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                20.height,
                CircleAvatar(
                  radius: 55,
                  child: cachedImage(
                    sugarCenter.image,
                    AssetsData.placeHolder,
                    fit: BoxFit.fill,
                    width: size.width / 2.5,
                    height: size.width / 2.5,
                  ).cornerRadiusWithClipRRect(55),
                ),
                20.height,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    sugarCenter.name??'',
                    style: Styles.bold19,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                15.height,
                Container(
                  width: size.width * .5,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColor.lightGrayColor),
                  ),
                  child: Text(
                    sugarCenter.phoneNumber??'',
                    style: Styles.semiBold16,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                6.height,
                CustomButton(
                  height: 40,
                  width: MediaQuery.of(context).size.width * .5,
                  text: 'Call',
                  onPressed: () {
                    launchPhoneDialer(sugarCenter.phoneNumber??'');
                  },
                ),
                20.height,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
