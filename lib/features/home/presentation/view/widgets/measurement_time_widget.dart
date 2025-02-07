import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

class MeasurementTimeWidget extends StatefulWidget {
  const MeasurementTimeWidget({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<String> onChanged;

  @override
  State<MeasurementTimeWidget> createState() => _CustomGenderWidgetState();
}

class _CustomGenderWidgetState extends State<MeasurementTimeWidget> {
  List<String> time = [
    'Fasting sugar (8-12 fast)',
    'Two hours after eating',
    'Before sleep',
    'After exercise',
    'Random time (when needed)',
  ];

  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      value: selectedTime,
      decoration: InputDecoration(
        filled: true,
        focusColor: AppColor.backgroundColor,
        fillColor: AppColor.whiteColor,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        alignLabelWithHint: false,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        label: Text('Measurement Time',
            style: Styles.regular13.copyWith(color: AppColor.lightGrayColor)),
        border: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
        errorBorder: buildOutlineInputBorder(),
      ),
      items: time
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: Styles.regular13.copyWith(color: AppColor.blackColor),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select measurement time';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          selectedTime = value.toString();
          widget.onChanged(selectedTime!);
        });
      },
      iconStyleData: IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          color: AppColor.lightGrayColor,
          size: 30,
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
    );
  }
}

OutlineInputBorder buildOutlineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: AppColor.lightGrayColor,
        width: .5,
      ));
}
