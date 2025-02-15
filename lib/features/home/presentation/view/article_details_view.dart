import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:smart_sugar/features/profile/domain/entity/article_entity.dart';
import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';
import '../../../../core/utils/widgets/cached_image.dart';

class ArticlesDetailsView extends StatefulWidget {
  const ArticlesDetailsView({super.key, required this.articleEntity,});

  final ArticleEntity articleEntity;
  static const String routeName = 'ArticlesDetailsView';

  @override
  State<ArticlesDetailsView> createState() => _ArticlesDetailsViewState();
}

class _ArticlesDetailsViewState extends State<ArticlesDetailsView> {
  Offset position = const Offset(50, 50);
  bool isZoomed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: buildAppBar(
        context,
        title: 'Articles Details',
        showProfile: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .19,
                child: cachedImage(widget.articleEntity.image, AssetsData.appLogo)
                    .cornerRadiusWithClipRRect(10),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.articleEntity.title,
                style: Styles.bold19,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.articleEntity.date,
                style: Styles.semiBold16.copyWith(color: AppColor.lightGrayColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Description',
                style: Styles.semiBold13.copyWith(color: AppColor.primaryColor),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.articleEntity.description,
                style: Styles.regular16,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
