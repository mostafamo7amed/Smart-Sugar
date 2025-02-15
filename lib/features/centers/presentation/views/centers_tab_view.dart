import 'package:flutter/material.dart';
import 'package:smart_sugar/core/utils/widgets/build_app_bar.dart';
import 'package:smart_sugar/features/centers/presentation/views/sugar_centers_view.dart';
import 'package:smart_sugar/features/centers/presentation/views/widgets/custom_tab_item.dart';
import 'package:smart_sugar/features/centers/presentation/views/emergency_numbers_view.dart';

import '../../../../core/utils/app_manager/app_colors.dart';

class CentersTabView extends StatefulWidget {
  const CentersTabView({super.key});

  @override
  State<CentersTabView> createState() => _CentersTabViewState();
}

class _CentersTabViewState extends State<CentersTabView> {
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
      appBar: buildAppBar(context, title: 'Emergency',showBackButton: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.fillColor,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      CustomTabItem(
                        onTap: () {
                          pageController.jumpToPage(0);
                          currentIndex = 0;
                          setState(() {});
                        },
                        title: 'Emergency',
                        isSelected: currentIndex,
                        index: 0,
                      ),
                      CustomTabItem(
                        onTap: () {
                          pageController.jumpToPage(1);
                          currentIndex = 1;
                          setState(() {});
                        },
                        title: 'Sugar Centers',
                        isSelected: currentIndex,
                        index: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: PageView(
                physics: BouncingScrollPhysics(),
                onPageChanged: (value) {
                  currentIndex = value;
                  setState(() {});
                },
                controller: pageController,
                children: [
                  EmergencyNumbersView(),
                  SugarCentersView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
