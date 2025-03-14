
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/core/utils/app_manager/app_styles.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/features/centers/presentation/views/my_list_sugar_centers_view.dart';
import 'package:smart_sugar/features/centers/presentation/views/sugar_details_view.dart';
import 'package:smart_sugar/features/centers/presentation/views/widgets/sugar_center_item_widget.dart';
import 'package:smart_sugar/features/home/presentation/manager/user_cubit.dart';

import '../../../../core/utils/app_manager/app_colors.dart';

class SugarCentersView extends StatelessWidget {
  const SugarCentersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return CustomProgressHud(
          isLoading: state is GetSugarCenterLoadingState,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColor.blueColor,
              onPressed: () {
                Navigator.pushNamed(context, MyListSugarCentersView.routeName);
              },
              child: Text(
                'My List',
                style: Styles.semiBold13.copyWith(color: AppColor.whiteColor),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: cubit.sugarCenterList.isEmpty
                  ? const Center(child: Text('No Sugar Centers'))
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, SugarDetailsView.routeName,
                              arguments: cubit.sugarCenterList[index]);
                        },
                        child: SugarCenterItemWidget(
                          sugarCenter: cubit.sugarCenterList[index],
                        ),
                      ),
                      itemCount: cubit.sugarCenterList.length,
                    ),
            ),
          ),
        );
      },
    );
  }
}
