import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:smart_sugar/features/home/presentation/manager/user_cubit.dart';

import '../../../../../core/utils/app_manager/app_assets.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';
import '../../../../../core/utils/widgets/cached_image.dart';

class ProfileTitleWidget extends StatelessWidget {
  const ProfileTitleWidget({
    super.key,
    required this.size,
    required this.name,
    required this.image,
  });

  final Size size;
  final String name, image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          width: size.width,
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    backgroundColor: AppColor.fillColor,
                    radius: 38,
                    child: cubit.pikedImage != null
                        ? Image.file(
                            cubit.pikedImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ).cornerRadiusWithClipRRect(50)
                        : cubit.userEntity?.image != ''
                            ? cachedImage(
                      height: 100,
                      width: 100,
                        cubit.userEntity!.image,
                                    AssetsData.placeHolder)
                                .cornerRadiusWithClipRRect(50)
                            : SvgPicture.asset(
                                AssetsData.profileIcon,
                                fit: BoxFit.scaleDown,
                                colorFilter: ColorFilter.mode(
                                    AppColor.pinkColor, BlendMode.srcIn),
                              ),
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
      },
    );
  }
}
