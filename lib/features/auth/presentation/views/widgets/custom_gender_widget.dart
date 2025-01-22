import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_sugar/core/utils/app_manager/app_assets.dart';
import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';
class CustomGenderWidget extends StatefulWidget {
  const CustomGenderWidget({super.key, required this.onChanged,});

  final ValueChanged<String> onChanged;

  @override
  State<CustomGenderWidget> createState() => _CustomGenderWidgetState();
}

class _CustomGenderWidgetState extends State<CustomGenderWidget> {

  List<String> gender = ['Male', 'Female'];

  String? selectedGender;


  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      value: selectedGender,
      decoration: InputDecoration(
        filled: true,
        focusColor:  AppColor.backgroundColor,
        fillColor:  AppColor.backgroundColor,
        prefixIcon: SvgPicture.asset(AssetsData.personIcon,fit: BoxFit.scaleDown,colorFilter: ColorFilter.mode(AppColor.pinkColor, BlendMode.srcIn),),
        contentPadding: const EdgeInsets.only(top: 16, bottom: 16, right: 12),
        floatingLabelBehavior: FloatingLabelBehavior.never,

        alignLabelWithHint: false,
        label: Text('Your Gender', style: Styles.regular16.copyWith(color: AppColor.lightGrayColor)),
        border: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
        errorBorder: buildOutlineInputBorder(),
      ),
      items: gender
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: Styles.regular16.copyWith(color: AppColor.blackColor),
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select gender';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          selectedGender = value.toString();
          widget.onChanged(selectedGender!);
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
        padding: EdgeInsets.symmetric(horizontal: 5),
      ),
    );
  }
}
OutlineInputBorder buildOutlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: AppColor.backgroundColor,
      width: 1,
    )
  );
}
