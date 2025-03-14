import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/features/home/presentation/manager/user_cubit.dart';
import 'package:smart_sugar/features/home/presentation/view/widgets/emergency_number_item_widget.dart';

import '../../../../core/helper_functions/url_launcher.dart';

class EmergencyNumbersView extends StatelessWidget {
  const EmergencyNumbersView({super.key});

  static const routeName = 'emergency-numbers';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return CustomProgressHud(
          isLoading: state is GetEmergencyNumberLoadingState,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: cubit.emergencyNumberList.isEmpty
                  ? const Center(child: Text('No Emergency Numbers'))
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          launchPhoneDialer(
                              cubit.emergencyNumberList[index].number, context);
                        },
                        child: EmergencyNumberItemWidget(
                          emergencyNumberEntity:
                              cubit.emergencyNumberList[index],
                        ),
                      ),
                      itemCount: cubit.emergencyNumberList.length,
                    ),
            ),
          ),
        );
      },
    );
  }
}
