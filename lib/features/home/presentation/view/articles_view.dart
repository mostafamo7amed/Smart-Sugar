import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/features/home/presentation/manager/user_cubit.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/article_card.dart';

class MedicalArticlesView extends StatefulWidget {
  const MedicalArticlesView({super.key});

  static const routeName = 'medical-articles';

  @override
  State<MedicalArticlesView> createState() => _MedicalArticlesViewState();
}

class _MedicalArticlesViewState extends State<MedicalArticlesView> {
  @override
  void initState() {
    UserCubit.get(context).getAllArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return Scaffold(
          appBar: buildAppBar(context, title: 'Medical Articles'),
          body: CustomProgressHud(
            isLoading: state is GetArticlesLoadingState,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: cubit.articleList.isEmpty
                  ? const Center(child: Text('No Articles Found'))
                  : ListView.builder(
                      itemCount: cubit.articleList.length,
                      itemBuilder: (context, index) {
                        return ArticleCard(
                          articleEntity: cubit.articleList[index],
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
