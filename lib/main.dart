import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:smart_sugar/core/services/dependency_injection.dart';
import 'package:smart_sugar/core/utils/app_manager/app_colors.dart';
import 'package:smart_sugar/features/splash/presentation/view/splash_view.dart';

import 'core/helper_functions/on_generate_routes.dart';
import 'core/services/app_references.dart';
import 'core/services/custom_bloc_observer.dart';
import 'core/services/git_it_services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppReference.init();
  setupGitIt();
  Bloc.observer = CustomBlocObserver(); //remember to remove this in production mode
  runApp(const SmartSugar());
  DependencyInjection.init();
}

class SmartSugar extends StatelessWidget {
  const SmartSugar({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Smart Sugar',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.backgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor:AppColor.blueColor),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName,
    );
  }
}
