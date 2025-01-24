import 'package:flutter/material.dart';
import 'package:smart_sugar/features/admin_feature/presentation/views/widgets/add_article_view.dart';

import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';
import '../../../profile/domain/entity/article_entity.dart';
import '../../../profile/presentation/views/widgets/article_card.dart';

class ManageArticlesView extends StatelessWidget {
  ManageArticlesView({super.key});
  static const routeName = 'ManageArticlesView';
  final List<ArticleEntity> articles = [
    ArticleEntity(
        contentUrl:
        'https://www.heartfoundation.org.au/healthy-living/keeping-your-heart-healthy',
        title: 'Understanding Heart Health',
        description:
        'Learn about the importance of heart health and how to maintain it.',
        image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFHOF1zISh_KPeE10EG7FE6k_L4bnSQX-IxQ&s'),
    ArticleEntity(
        contentUrl: 'https://www.cdc.gov/nutrition/php/resources/healthy-eating-benefits-for-adults.html',
        title: 'The Benefits of a Balanced Diet',
        description:
        'Learn about the importance of heart health and how to maintain it.',
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFHOF1zISh_KPeE10EG7FE6k_L4bnSQX-IxQ&s'),
    ArticleEntity(
        contentUrl: 'https://www.mayoclinichealthsystem.org/hometown-health/speaking-of-health/5-tips-to-manage-stress',
        title: 'Managing Stress Effectively',
        description:
        'Learn about the importance of heart health and how to maintain it.',
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFHOF1zISh_KPeE10EG7FE6k_L4bnSQX-IxQ&s'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Medical Articles',showProfile: false),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: FloatingActionButton(
          backgroundColor: AppColor.primaryColor,
          child: Icon(
            size: 30,
            Icons.add,
            color: AppColor.whiteColor,
          ),
          onPressed: () {
           Navigator.pushNamed(context, AddArticleView.routeName);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return ArticleCard(
              articleEntity: articles[index],
              isManage: true,
            );
          },
        ),
      ),
    );
  }
}
