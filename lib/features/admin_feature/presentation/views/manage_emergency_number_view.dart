import 'package:flutter/material.dart';
import 'package:smart_sugar/features/admin_feature/presentation/views/widgets/add_emergency_number_view.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';
import '../../../home/presentation/view/widgets/emergency_number_item_widget.dart';

class ManageEmergencyNumberView extends StatelessWidget {
  const ManageEmergencyNumberView({super.key});
  static const routeName = 'ManageEmergencyNumberView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Manage Numbers', showProfile: false),
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
            Navigator.pushNamed(context, AddEmergencyNumberView.routeName);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => EmergencyNumberItemWidget(
            isManage: true,
          ),
          itemCount: 3,
        ),
      ),
    );
  }
}
