import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/extensions.dart';
import 'package:smart_sugar/features/profile/presentation/views/add_reminder_view.dart';

import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/app_manager/app_styles.dart';
import '../../../../core/utils/widgets/build_app_bar.dart';
import '../../domain/entity/medication_reminder.dart';

class MedicationReminderView extends StatefulWidget {
  const MedicationReminderView({super.key});
  static const routeName = 'medicationReminderView';

  @override
  MedicationReminderViewState createState() => MedicationReminderViewState();
}

class MedicationReminderViewState extends State<MedicationReminderView> {
  final List<MedicationReminder> _reminders = [
    MedicationReminder(
      id: '1',
      name: 'Medication 1',
      dosage: '2 tablets',
      time: TimeOfDay(hour: 12, minute: 0),
      days: ['Mon', 'Wed'],
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Reminders',
        isProfile: false,
      ),
      body: _buildRemindersList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppColor.whiteColor),
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, AddReminderView.routeName);
          if (result != null) {
            setState(() {
              _reminders.add(result as MedicationReminder);
            });
          }
        },
      ),
    );
  }

  Widget _buildRemindersList() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: _reminders.length,
        itemBuilder: (context, index) {
          final reminder = _reminders[index];
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
            onDismissed: (direction) => _removeReminder(reminder.id),
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
                    Text('Time: ${reminder.time.format(context)}',
                        style: Styles.semiBold13),
                    Text('Days: ${reminder.days.join(", ")}',
                        style: Styles.semiBold13),
                  ],
                ),
                trailing: Switch(
                  activeColor: AppColor.primaryColor,
                  value: reminder.isActive,
                  onChanged: (value) => _toggleReminder(reminder.id),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _removeReminder(String id) {
    setState(() {
      _reminders.removeWhere((reminder) => reminder.id == id);
    });
  }

  void _toggleReminder(String id) {
    setState(() {
      final index = _reminders.indexWhere((r) => r.id == id);
      _reminders[index] = _reminders[index].copyWith(
        isActive: !_reminders[index].isActive,
      );
    });
  }
}
