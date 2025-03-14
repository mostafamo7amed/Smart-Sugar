import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/features/centers/presentation/views/sugar_details_view.dart';
import 'package:smart_sugar/features/centers/presentation/views/widgets/sugar_center_item_widget.dart';
import 'package:smart_sugar/features/home/presentation/manager/user_cubit.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';

class MyListSugarCentersView extends StatefulWidget {
  const MyListSugarCentersView({super.key});

  static const routeName = 'myListSugarCentersView';

  @override
  State<MyListSugarCentersView> createState() => _MyListSugarCentersViewState();
}

class _MyListSugarCentersViewState extends State<MyListSugarCentersView> {
  @override
  void initState() {
    UserCubit.get(context).getMySugarCenter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return CustomProgressHud(
          isLoading: state is GetMySugarCenterLoadingState,
          child: Scaffold(
            appBar:
            buildAppBar(context, title: 'My List', showBackButton: true,),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SugarDetailsView.routeName,
                            arguments: cubit.mySugarCenterList[index]);
                      },
                      child: SugarCenterItemWidget(
sugarCenter: cubit.mySugarCenterList[index],
                      ),
                    ),
                itemCount: cubit.mySugarCenterList.length,
              ),
            ),
          ),
        );
      },
    );
  }
}
