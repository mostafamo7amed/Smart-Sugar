import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:smart_sugar/core/services/dependency_injection.dart';
import 'package:smart_sugar/core/services/local_notification_services.dart';
import 'package:smart_sugar/core/services/work_manager.dart';
import 'package:smart_sugar/core/utils/app_manager/app_colors.dart';
import 'package:smart_sugar/features/admin_feature/presentation/manager/admin_cubit.dart';
import 'package:smart_sugar/features/home/presentation/manager/user_cubit.dart';
import 'package:smart_sugar/features/splash/presentation/view/splash_view.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'core/helper_functions/on_generate_routes.dart';
import 'core/services/app_references.dart';
import 'core/services/custom_bloc_observer.dart';
import 'core/services/git_it_services.dart';
import 'features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'features/auth/presentation/manager/register_cubit/register_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones();
  LocalNotificationServices.initialize();
  await AppReference.init();
  LocalNotificationServices.requestPermissions();
  setupGitIt();
  Bloc.observer = CustomBlocObserver();
  runApp(const SmartSugar());
  DependencyInjection.init();
}

class SmartSugar extends StatelessWidget {
  const SmartSugar({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(
          create: (context) => AdminCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        )
      ],
      child: GetMaterialApp(
        title: 'Smart Sugar',
        theme: ThemeData(
          unselectedWidgetColor: AppColor.lightGrayColor,
          scaffoldBackgroundColor: AppColor.backgroundColor,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.lightGrayColor),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        initialRoute: SplashView.routeName,
      ),
    );
  }
}
