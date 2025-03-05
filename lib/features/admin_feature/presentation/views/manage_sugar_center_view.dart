
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/features/admin_feature/presentation/manager/admin_cubit.dart';
import 'package:smart_sugar/features/admin_feature/presentation/views/widgets/delete_sugar_center_view.dart';

import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../centers/presentation/views/widgets/sugar_center_item_widget.dart';
import 'widgets/add_sugar_center_view.dart';

class ManageSugarCenterView extends StatefulWidget {
  const ManageSugarCenterView({super.key});
  static const routeName = 'ManageSugarCenterView';

  @override
  State<ManageSugarCenterView> createState() => _ManageSugarCenterViewState();
}

class _ManageSugarCenterViewState extends State<ManageSugarCenterView> {
  @override
  void initState() {
    AdminCubit.get(context).getAllSugarCenter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return CustomProgressHud(
          isLoading: state is GetSugarCenterLoadingState,
          child: Scaffold(
            appBar: buildAppBar(context,
                title: 'Manage Sugar Centers', showProfile: false),
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
                  Navigator.pushNamed(context, AddSugarCenterView.routeName);
                },
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
                              context, DeleteSugarCenterView.routeName,
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
