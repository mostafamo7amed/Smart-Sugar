import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_sugar/core/utils/app_manager/app_assets.dart';
import 'package:smart_sugar/core/utils/app_manager/app_colors.dart';
import 'package:smart_sugar/core/utils/app_manager/app_styles.dart';
import 'package:smart_sugar/core/utils/widgets/custom_text_form_field.dart';
import 'package:smart_sugar/features/auth/presentation/views/widgets/custom_gender_widget.dart';

import 'custom_divider.dart';

class OnBoardingPageOne extends StatefulWidget {
  const OnBoardingPageOne({super.key, required this.onGenderChanged, required this.onAgeChanged, required this.onWeightChanged, this.formKey});

  final ValueChanged <String> onGenderChanged;
  final ValueChanged <String> onAgeChanged;
  final ValueChanged <String> onWeightChanged;
  final GlobalKey<FormState>? formKey;

  @override
  State<OnBoardingPageOne> createState() => _OnBoardingPageOneState();
}

class _OnBoardingPageOneState extends State<OnBoardingPageOne> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Till us about yourself',
                style: Styles.bold23,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Your individual parameters are important for Dia in-depth personalization.',
                style: Styles.regular16.copyWith(color: AppColor.lightGrayColor),
              ),
              SizedBox(
                height: 10,
              ),
              CustomGenderWidget(
                onChanged: (value) {
                  widget.onGenderChanged(value);
                  setState(() {});
                },
              ),
              CustomDivider(),
              CustomTextFormField(
                noBorder: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      AssetsData.weightIcon,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                hintText: 'Your Weight',
                suffixIcon: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'KG',
                      style: Styles.bold19.copyWith(
                          color: AppColor.lightGrayColor,
                          fontWeight: FontWeight.normal),
                    )),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  widget.onWeightChanged(value!);
                  setState(() {});
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                },
              ),
              CustomDivider(),
              CustomTextFormField(
                noBorder: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      AssetsData.weightIcon,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                hintText: 'Your Height',
                suffixIcon: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'CM',
                      style: Styles.bold19.copyWith(
                          color: AppColor.lightGrayColor,
                          fontWeight: FontWeight.normal),
                    )),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  widget.onWeightChanged(value!);
                  setState(() {});
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Height';
                  }
                  return null;
                },
              ),
              CustomDivider(),
              CustomTextFormField(
                noBorder: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(
                      AssetsData.ageIcon,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                hintText: 'Your Date of Birth',
                suffixIcon: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: AppColor.lightGrayColor,
                      size: 30,
                    )),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  widget.onAgeChanged(value!);
                  setState(() {});
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your date of birth';
                  }
                  return null;
                },
              ),
              CustomDivider(),
            ],
          ),
        ),
      ),
    );
  }
}
