import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/widgets/custom_text_form_field.dart';

import '../../../../../core/utils/app_manager/app_colors.dart';
import '../../../../../core/utils/app_manager/app_styles.dart';

class OnBoardingPageFour extends StatelessWidget {
  const OnBoardingPageFour({super.key, required this.formKey, required this.onGlucoseLowValueChanged, required this.onGlucoseHighValueChanged});

  final GlobalKey<FormState> formKey;
  final ValueChanged<String> onGlucoseLowValueChanged;
  final ValueChanged<String> onGlucoseHighValueChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your blood sugar goal before meal ',
                style: Styles.bold23,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'You need to add lowest value and highest value for your blood sugar before meal.',
                style: Styles.regular16.copyWith(color: AppColor.lightGrayColor),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hintText: 'Lowest level',
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  onGlucoseLowValueChanged(value!);
                },
                suffixIcon: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'mg/dl  ',
                    style: Styles.regular16.copyWith(
                      color: AppColor.lightGrayColor,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter lowest value';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
              CustomTextFormField(
                hintText: 'Highest level',
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  onGlucoseHighValueChanged(value!);
                },
                suffixIcon: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'mg/dl  ',
                    style: Styles.regular16.copyWith(
                      color: AppColor.lightGrayColor,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter highest value';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
