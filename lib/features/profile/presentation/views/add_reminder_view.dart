
import 'package:flutter/material.dart';
import 'package:smart_sugar/core/helper_functions/pike_time.dart';
import 'package:smart_sugar/core/utils/app_manager/app_styles.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/core/utils/widgets/custom_button.dart';
import 'package:smart_sugar/core/utils/widgets/custom_text_form_field.dart';

import '../../../../core/utils/app_manager/app_colors.dart';
import '../../domain/entity/medication_reminder.dart';

class AddReminderView extends StatefulWidget {
  const AddReminderView({super.key});
  static const routeName = 'addReminderView';
  @override
  AddReminderViewState createState() => AddReminderViewState();
}

class AddReminderViewState extends State<AddReminderView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final List<String> _selectedDays = [];
  final List<String> _daysOfWeek = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Add Reminder', isProfile: false),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                controller: _nameController,
                hintText: 'Medication Name',
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: _dosageController,
                hintText: 'Dosage',
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              _buildTimePicker(),
              SizedBox(height: 10),
              Text('Select Days:', style: Styles.semiBold13.copyWith(color: AppColor.lightGrayColor),),
              _buildDaySelector(),
              SizedBox(height: 20),
              CustomButton(onPressed: () =>  _submitForm(), text: 'Save Reminder',),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return ListTile(
      title: Text('Time'),
      subtitle: Text(_selectedTime.format(context)),
      leading: Icon(Icons.access_time),
      onTap: () async {
        DateTime? time = await pickTime(context);
        TimeOfDay timeOfDay = TimeOfDay.fromDateTime(time!);
        setState(() => _selectedTime = timeOfDay);
            },
    );
  }

  Widget _buildDaySelector() {
    return Wrap(
      spacing: 5,
      children: _daysOfWeek.map((day) {
        final isSelected = _selectedDays.contains(day);
        return FilterChip(
          label: Text(day),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedDays.add(day);
              } else {
                _selectedDays.remove(day);
              }
            });
          },
        );
      }).toList(),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedDays.isNotEmpty) {
      final newReminder = MedicationReminder(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        dosage: _dosageController.text,
        time: _selectedTime,
        days: _selectedDays,
      );
      Navigator.pop(context, newReminder);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    super.dispose();
  }
}

