import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/features/admin_feature/presentation/manager/admin_cubit.dart';
import 'package:smart_sugar/features/admin_feature/presentation/views/widgets/add_emergency_number_view.dart';
import '../../../../core/helper_functions/get_snack_bar.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';
import '../../../home/presentation/view/widgets/emergency_number_item_widget.dart';

class ManageEmergencyNumberView extends StatefulWidget {
  const ManageEmergencyNumberView({super.key});
  static const routeName = 'ManageEmergencyNumberView';

  @override
  State<ManageEmergencyNumberView> createState() =>
      _ManageEmergencyNumberViewState();
}

class _ManageEmergencyNumberViewState extends State<ManageEmergencyNumberView> {
  @override
  void initState() {
    AdminCubit.get(context).getAllEmergencyNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is DeleteEmergencyNumberSuccessState) {
          getSnackBar('Emergency Number Deleted Successfully');
          AdminCubit.get(context).getAllEmergencyNumber();
        }
      },
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return CustomProgressHud(
          isLoading: state is GetEmergencyNumberLoadingState ||
              state is DeleteEmergencyNumberLoadingState,
          child: Scaffold(
            appBar: buildAppBar(context,
                title: 'Manage Numbers', showProfile: false),
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
                  Navigator.pushNamed(
                      context, AddEmergencyNumberView.routeName);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: cubit.emergencyNumberList.isEmpty
                  ? const Center(child: Text('No Emergency Numbers'))
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          EmergencyNumberItemWidget(
                        isManage: true,
                        onDelete: () {
                          cubit.deleteEmergencyNumber(
                              cubit.emergencyNumberList[index].id);
                          Navigator.pop(context);
                        },
                        emergencyNumberEntity: cubit.emergencyNumberList[index],
                      ),
                      itemCount: cubit.emergencyNumberList.length ?? 3,
                    ),
            ),
          ),
        );
      },
    );
  }
}
