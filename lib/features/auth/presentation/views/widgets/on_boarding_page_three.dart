import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/app_manager/app_colors.dart';
import 'package:smart_sugar/core/utils/app_manager/app_styles.dart';
import 'package:smart_sugar/features/auth/presentation/views/widgets/custom_divider.dart';

import '../../../../../core/utils/widgets/custom_text_form_field.dart';

class OnBoardingPageThree extends StatefulWidget {
  const OnBoardingPageThree({super.key, required this.onTherapy1Changed, required this.onInsulinChanged, required this.onTherapy2Changed, required this.formKey});
  final ValueChanged<String> onTherapy1Changed;
  final ValueChanged<String> onTherapy2Changed;
  final ValueChanged<String> onInsulinChanged;
  final GlobalKey<FormState> formKey;


  @override
  State<OnBoardingPageThree> createState() => _OnBoardingPageTwoState();
}

class _OnBoardingPageTwoState extends State<OnBoardingPageThree> {
  bool check1 = false;
  bool check2 = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What is your therapy?',
                style: Styles.bold23,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'You can choose multiple options.',
                style: Styles.regular16.copyWith(color: AppColor.lightGrayColor),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  check1 = !check1;
                  if(check1){
                    widget.onTherapy1Changed('Insulin Therapy');
                  }else{
                    widget.onTherapy1Changed('');
                  }
                  setState(() {});
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: check1
                        ? AppColor.primaryColor.withValues(alpha: .2)
                        : AppColor.checkBoxColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            fillColor: WidgetStateProperty.resolveWith<Color>(
                                (Set<WidgetState> states) {
                              return check1
                                  ? AppColor.primaryColor
                                  : AppColor.checkBoxColor;
                            }),
                            activeColor: AppColor.primaryColor,
                            onChanged: (value) {
                              check1 = value!;
                              if(check1){
                                widget.onTherapy1Changed('Insulin Therapy');
                              }else{
                                widget.onTherapy1Changed('');
                              }
                              setState(() {
                              });
                            },
                            value: check1,
                            side: BorderSide(
                              color: AppColor.lightGrayColor,
                              width: 1.5,
                            ),
                          ),
                          Text(
                            'Insulin Therapy',
                            style: Styles.regular16,
                          ),
                        ],
                      ),
                        Visibility(
                          visible: check1,
                          child: Column(
                            children: [
                              CustomDivider(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  'What amount of short acting insulin do you take a day?',
                                  style: Styles.regular13.copyWith(
                                      color: AppColor.lightGrayColor, fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                child: CustomTextFormField(
                                  noBorder: true,
                                  hintText: 'value',
                                  onSaved: (value) {
                                    widget.onInsulinChanged(value!);
                                    setState(() {});
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
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  check2 = !check2;
                  if(check2){
                    widget.onTherapy2Changed('Pills');
                  }else{
                    widget.onTherapy2Changed('');
                  }
                  setState(() {});
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: check2
                        ? AppColor.primaryColor.withValues(alpha: .2)
                        : AppColor.checkBoxColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        fillColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          return (states.contains(WidgetState.selected))
                              ? AppColor.primaryColor
                              : AppColor.checkBoxColor;
                        }),
                        activeColor: AppColor.primaryColor,
                        value: check2,
                        onChanged: (value) {
                          check2 = value!;
                          if(check2){
                            widget.onTherapy2Changed('Pills');
                          }else{
                            widget.onTherapy2Changed('');
                          }
                          setState(() {});
                        },
                        side: BorderSide(
                          color: AppColor.lightGrayColor,
                          width: 1.5,
                        ),
                      ),
                      Text(
                        'Pills',
                        style: Styles.regular16,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
