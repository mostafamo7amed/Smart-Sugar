import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/features/admin_feature/presentation/manager/admin_cubit.dart';
import 'package:smart_sugar/features/admin_feature/presentation/views/widgets/add_article_view.dart';

import '../../../../core/helper_functions/get_snack_bar.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';
import '../../../home/presentation/view/widgets/article_card.dart';

class ManageArticlesView extends StatefulWidget {
  const ManageArticlesView({super.key});

  static const routeName = 'ManageArticlesView';

  @override
  State<ManageArticlesView> createState() => _ManageArticlesViewState();
}

class _ManageArticlesViewState extends State<ManageArticlesView> {
  @override
  void initState() {
    AdminCubit.get(context).getAllArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is DeleteArticleSuccessState) {
          getSnackBar('Article Deleted Successfully');
          AdminCubit.get(context).getAllArticles();
        }
      },
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return CustomProgressHud(
          isLoading: state is GetArticlesLoadingState ||
              state is DeleteArticleLoadingState,
          child: Scaffold(
            appBar: buildAppBar(context,
                title: 'Medical Articles', showProfile: false),
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
              child: cubit.articleList.isEmpty
                  ? const Center(child: Text('No Articles'))
                  : ListView.builder(
                      itemCount: cubit.articleList.length,
                      itemBuilder: (context, index) {
                        return ArticleCard(
                          onDelete: () {
                            cubit.deleteArticle(
                                cubit.articleList[index].id ?? '');
                            Navigator.pop(context);
                          },
                          articleEntity: cubit.articleList[index],
                          isManage: true,
                        );
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}
