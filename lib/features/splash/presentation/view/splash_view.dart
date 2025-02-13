import 'package:flutter/material.dart';
import 'package:smart_sugar/features/home/presentation/view/user_home_root.dart';

import '../../../../constants.dart';
import '../../../../core/services/app_references.dart';
import '../../../../core/utils/app_manager/app_assets.dart';
import '../../../auth/presentation/views/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const routeName = 'splash';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    executeNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 345 / 351,
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Image.asset(AssetsData.appLogo),
          ),
        ),
      ),
    );
  }

  void executeNavigation() {
    bool isAuthorized = AppReference.getData(key: authKey) ?? false;
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      if (isAuthorized) {
        Navigator.pushReplacementNamed(context, UserHomeRoot.routeName);
      } else {
        Navigator.pushReplacementNamed(context, LoginView.routeName);
      }
    });
  }
}
