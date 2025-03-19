import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sugar/core/services/app_references.dart';
import 'package:smart_sugar/features/home/presentation/manager/user_cubit.dart';
import 'package:smart_sugar/features/profile/presentation/views/add_reminder_view.dart';

import '../../../../constants.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';

class MedicationReminderView extends StatefulWidget {
  const MedicationReminderView({super.key});

  static const routeName = 'medicationReminderView';

  @override
  MedicationReminderViewState createState() => MedicationReminderViewState();
}

class MedicationReminderViewState extends State<MedicationReminderView> {
  @override
  void initState() {
    super.initState();
    UserCubit.get(context)
        .getMedicationReminders(AppReference.getData(key: userIdKey));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Reminders',
        isProfile: false,
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if(state is UpdateMedicationStatusSuccessState){
            UserCubit.get(context)
                .getMedicationReminders(AppReference.getData(key: userIdKey));
          }
        },
        builder: (context, state) {
          var cubit = UserCubit.get(context);
          return cubit.medicationReminders.isEmpty
              ? const Center(child: Text('No Reminders'))
              : _buildRemindersList(
                  cubit: cubit,
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppColor.whiteColor),
        onPressed: () async {
          Navigator.pushNamed(context, AddReminderView.routeName);
        },
      ),
    );
  }

  Widget _buildRemindersList({required UserCubit cubit}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: cubit.medicationReminders.length,
        itemBuilder: (context, index) {
          final reminder = cubit.medicationReminders[index];
          bool switchValue = reminder.isActive;
          return Dismissible(
            key: Key(reminder.id),
            background: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: AppColor.redColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      ),
                      Spacer(),
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                )),
            onDismissed: (direction) {
              cubit.removeMedicationReminder(reminder.id);
            },
            child: Card(
              color: AppColor.whiteColor,
              elevation: 2,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                leading: Icon(Icons.medical_services,
                    color: AppColor.lightGrayColor),
                title: Text(reminder.name, style: Styles.semiBold16),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dosage: ${reminder.dosage}',
                        style: Styles.semiBold13),
                    Text('Time: ${reminder.time}', style: Styles.semiBold13),
                    Text('Days: ${reminder.days.join(", ")}',
                        style: Styles.semiBold13),
                  ],
                ),
                trailing: Switch(
                  activeColor: AppColor.primaryColor,
                  value: switchValue,
                  onChanged: (value) {
                    setState(() {
                      switchValue =  !switchValue;
                    });
                    cubit.updateMedicationStatus(
                        reminder.id, !reminder.isActive);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
