import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:smart_sugar/core/helper_functions/get_snack_bar.dart';
import 'package:smart_sugar/core/utils/widgets/custom_progress_hud.dart';
import 'package:smart_sugar/features/auth/presentation/manager/register_cubit/register_cubit.dart';
import 'package:smart_sugar/features/auth/presentation/views/widgets/on_boarding_page_four.dart';
import 'package:smart_sugar/features/auth/presentation/views/widgets/on_boarding_page_one.dart';
import 'package:smart_sugar/features/auth/presentation/views/widgets/on_boarding_page_three.dart';
import 'package:smart_sugar/features/auth/presentation/views/widgets/on_boarding_page_two.dart';
import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/widgets/custom_button.dart';
import '../../../home/presentation/view/user_home_root.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  static const String routeName = "onBoardingView";

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late PageController pageController;
  int currentIndex = 0;
  String? gender,
      dateOfBirth,
      wight,
      height,
      diabetesType,
      therapy1Type,
      therapy2Type,
      insulinValue,
      glucoseLowValue,
      glucoseHighValue;
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();

  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      currentIndex = pageController.page!.round();
      setState(() {});
    });
    super.initState();
  }

  @override
  dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterCreateUserSuccess) {
          getSnackBar('Account created successfully');
          Navigator.of(context).pushReplacementNamed(UserHomeRoot.routeName);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is RegisterCreateUserLoading ? true : false,
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: Row(
                      children: [
                        Visibility(
                          visible: currentIndex != 0,
                          child: GestureDetector(
                            onTap: () {
                              pageController.jumpToPage(--currentIndex);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColor.lightGrayColor,
                            ),
                          ),
                        ),
                        if (currentIndex != 0)
                          SizedBox(
                            width: 10,
                          ),
                        Expanded(
                          child: LinearProgressBar(
                            maxSteps: 4,
                            progressType: LinearProgressBar.progressTypeLinear,
                            // Use Linear progress
                            currentStep: currentIndex + 1,
                            progressColor: AppColor.orangeColor,
                            backgroundColor: AppColor.lightGrayColor,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(10), //  NEW
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (value) {
                        currentIndex == value;
                        setState(() {});
                      },
                      controller: pageController,
                      children: [
                        OnBoardingPageOne(
                          formKey: formKey1,
                          onAgeChanged: (value) {
                            dateOfBirth = value;
                            setState(() {});
                          },
                          onGenderChanged: (value) {
                            gender = value;
                            setState(() {});
                          },
                          onWeightChanged: (value) {
                            wight = value;
                            setState(() {});
                          },
                          onHeightChanged: (value) {
                            height = value;
                            setState(() {});
                          },
                        ),
                        OnBoardingPageTwo(
                          onDiabetesTypeChanged: (value) {
                            diabetesType = value;
                            setState(() {});
                          },
                        ),
                        OnBoardingPageThree(
                          formKey: formKey3,
                          onInsulinChanged: (value) {
                            insulinValue = value;
                            setState(() {});
                          },
                          onTherapy2Changed: (value) {
                            therapy2Type = value;
                            setState(() {});
                          },
                          onTherapy1Changed: (value) {
                            therapy1Type = value;
                            setState(() {});
                          },
                        ),
                        OnBoardingPageFour(
                          formKey: formKey2,
                          onGlucoseHighValueChanged: (value) {
                            glucoseHighValue = value;
                            setState(() {});
                          },
                          onGlucoseLowValueChanged: (value) {
                            glucoseLowValue = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    onPressed: () {
                      if (currentIndex < 3) {
                        if (currentIndex == 0) {
                          if (formKey1.currentState!.validate()) {
                            formKey1.currentState!.save();
                            log(dateOfBirth! + gender! + wight! + height!);
                            pageController.jumpToPage(++currentIndex);
                            setState(() {});
                          }
                        } else if (currentIndex == 1) {
                          if (diabetesType != null) {
                            log(diabetesType!);
                            pageController.jumpToPage(++currentIndex);
                            setState(() {});
                          } else {
                            getSnackBar('Please select diabetes type');
                          }
                        } else if (currentIndex == 2) {
                          if (therapy1Type != null) {
                            if (formKey3.currentState!.validate()) {
                              formKey3.currentState!.save();
                              pageController.jumpToPage(++currentIndex);
                              setState(() {});
                            }
                            log(therapy1Type ?? '');
                            log(insulinValue ?? '');
                          } else if (therapy2Type != null) {
                            pageController.jumpToPage(++currentIndex);
                            setState(() {});
                            log(therapy2Type ?? '');
                          } else {
                            getSnackBar('Please select therapy type');
                          }
                        }
                      } else {
                        if (formKey2.currentState!.validate()) {
                          formKey2.currentState!.save();
                          log(glucoseHighValue! + glucoseLowValue!);
                          context.read<RegisterCubit>().createUser(
                                dateOfBirth: dateOfBirth!,
                                height: height!,
                                gender: gender!,
                                wight: wight!,
                                diabetesType: diabetesType!,
                                therapyType:
                                    '${therapy1Type ?? ''} ${therapy2Type ?? ''}',
                                insulinValue: insulinValue ?? '',
                                glucoseLowValue: glucoseLowValue!,
                                glucoseHighValue: glucoseHighValue!,
                              );
                          Navigator.of(context)
                              .pushReplacementNamed(UserHomeRoot.routeName);
                        }
                      }
                    },
                    text: currentIndex == 3 ? "Let’s go" : "Next",
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
