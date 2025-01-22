import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/app_manager/app_colors.dart';
import 'package:smart_sugar/core/utils/app_manager/app_styles.dart';

class OnBoardingPageTwo extends StatefulWidget {
  const OnBoardingPageTwo({super.key});

  @override
  State<OnBoardingPageTwo> createState() => _OnBoardingPageTwoState();
}

class _OnBoardingPageTwoState extends State<OnBoardingPageTwo> {
  int groupValue = -1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What is diabetes type do you have?',
            style: Styles.bold23,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Select your diabetes type',
            style: Styles.regular16.copyWith(color: AppColor.lightGrayColor),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              groupValue = 1;
              setState(() {});
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: groupValue == 1
                    ? AppColor.primaryColor.withValues(alpha: .2)
                    : AppColor.checkBoxColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Radio(
                    fillColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      return (states.contains(WidgetState.selected))
                          ? AppColor.primaryColor
                          : AppColor.lightGrayColor;
                    }),
                    activeColor: AppColor.primaryColor,
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  Text(
                    'Type 1',
                    style: Styles.regular16,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              groupValue = 2;
              setState(() {});
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: groupValue == 2
                    ? AppColor.primaryColor.withValues(alpha: .2)
                    : AppColor.checkBoxColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Radio(
                    fillColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      return (states.contains(WidgetState.selected))
                          ? AppColor.primaryColor
                          : AppColor.lightGrayColor;
                    }),
                    activeColor: AppColor.primaryColor,
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  Text(
                    'Type 2',
                    style: Styles.regular16,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              groupValue = 3;
              setState(() {});
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: groupValue == 3
                    ? AppColor.primaryColor.withValues(alpha: .2)
                    : AppColor.checkBoxColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Radio(
                    fillColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                      return (states.contains(WidgetState.selected))
                          ? AppColor.primaryColor
                          : AppColor.lightGrayColor;
                    }),
                    activeColor: AppColor.primaryColor,
                    value: 3,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  Text(
                    'Gestational Diabetes',
                    style: Styles.regular16,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
