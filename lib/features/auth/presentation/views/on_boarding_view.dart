import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:smart_sugar/features/auth/presentation/views/widgets/on_boarding_page_four.dart';
import 'package:smart_sugar/features/auth/presentation/views/widgets/on_boarding_page_one.dart';
import 'package:smart_sugar/features/auth/presentation/views/widgets/on_boarding_page_three.dart';
import 'package:smart_sugar/features/auth/presentation/views/widgets/on_boarding_page_two.dart';
import 'package:smart_sugar/features/home/presentation/view/user_home_root.dart';

import '../../../../core/utils/app_manager/app_colors.dart';
import '../../../../core/utils/widgets/custom_button.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});
  static const String routeName = "onBoardingView";

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late PageController pageController;
  int currentIndex = 0;
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
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
                      progressType: LinearProgressBar
                          .progressTypeLinear, // Use Linear progress
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
                onPageChanged: (value) {
                  currentIndex == value;
                  setState(() {});
                },
                controller: pageController,
                children: [
                  OnBoardingPageOne(),
                  OnBoardingPageTwo(),
                  OnBoardingPageThree(),
                  OnBoardingPageFour()
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              onPressed: () {
                if (currentIndex < 3) {
                  pageController.jumpToPage(++currentIndex);
                  setState(() {});
                } else {
                  Navigator.of(context)
                      .pushReplacementNamed(UserHomeRoot.routeName);
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
    );
  }
}
