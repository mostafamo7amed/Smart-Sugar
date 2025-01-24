import 'package:flutter/material.dart';
import 'package:smart_sugar/features/splash/presentation/view/splash_view.dart';

import '../../features/auth/presentation/views/forget_password_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/on_boarding_view.dart';
import '../../features/auth/presentation/views/register_view.dart';
import '../../features/centers/domain/entities/sugar_center_entity.dart';
import '../../features/centers/presentation/views/add_to_list_view.dart';
import '../../features/centers/presentation/views/choose_district_view.dart';
import '../../features/centers/presentation/views/sugar_details_view.dart';
import '../../features/diet/domain/entities/meal_entity.dart';
import '../../features/diet/presentation/view/all_meals_view.dart';
import '../../features/diet/presentation/view/meal_details_view.dart';
import '../../features/home/presentation/view/emergency_numbers_view.dart';
import '../../features/home/presentation/view/home_view.dart';
import '../../features/home/presentation/view/notification_view.dart';
import '../../features/home/presentation/view/read_glucose_view.dart';
import '../../features/home/presentation/view/user_home_root.dart';
import '../../features/profile/presentation/views/articles_view.dart';
import '../../features/profile/presentation/views/glucose_report_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case RegisterView.routeName:
      return MaterialPageRoute(builder: (_) => const RegisterView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());
    case ForgetPasswordView.routeName:
      return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case UserHomeRoot.routeName:
      return MaterialPageRoute(builder: (_) => const UserHomeRoot());
    case NotificationView.routeName:
      return MaterialPageRoute(builder: (_) => const NotificationView());
    case ReadGlucoseView.routeName:
      return MaterialPageRoute(builder: (_) => const ReadGlucoseView());
    case EmergencyNumbersView.routeName:
      return MaterialPageRoute(builder: (_) => const EmergencyNumbersView());
    case AllMealsView.routeName:
      return MaterialPageRoute(
          builder: (_) => AllMealsView(
                mealType: settings.arguments.toString(),
              ),
      );
    case MealDetailsView.routeName:
      return MaterialPageRoute(
          builder: (_) => MealDetailsView(
            mealEntity: settings.arguments as MealEntity,
          ),
      );
    case SugarDetailsView.routeName:
      return MaterialPageRoute(builder: (_) =>  SugarDetailsView(sugarCenter: settings.arguments as SugarCenterEntity,));
    case AddToListView.routeName:
      return MaterialPageRoute(builder: (_) => const AddToListView());
    case ChooseDistrictView.routeName:
      return MaterialPageRoute(builder: (_) => const ChooseDistrictView());
    case MedicalArticlesView.routeName:
      return MaterialPageRoute(builder: (_) => MedicalArticlesView());
    case GlucoseReportView.routeName:
      return MaterialPageRoute(builder: (_) => GlucoseReportView());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
