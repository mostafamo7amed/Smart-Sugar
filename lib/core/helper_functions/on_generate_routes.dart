import 'package:flutter/material.dart';
import 'package:smart_sugar/features/admin_feature/presentation/views/refresh_api_view.dart';
import 'package:smart_sugar/features/splash/presentation/view/splash_view.dart';

import '../../features/admin_feature/presentation/views/manage_articles_view.dart';
import '../../features/admin_feature/presentation/views/widgets/add_article_view.dart';
import '../../features/admin_feature/presentation/views/widgets/add_emergency_number_view.dart';
import '../../features/admin_feature/presentation/views/widgets/add_sugar_center_view.dart';
import '../../features/admin_feature/presentation/views/admin_home_view.dart';
import '../../features/admin_feature/presentation/views/widgets/delete_sugar_center_view.dart';
import '../../features/admin_feature/presentation/views/manage_emergency_number_view.dart';
import '../../features/admin_feature/presentation/views/manage_sugar_center_view.dart';
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
import '../../features/profile/presentation/views/edit_profile_view.dart';
import '../../features/profile/presentation/views/glucose_report_view.dart';
import '../../features/profile/presentation/views/profile_view.dart';

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
      return MaterialPageRoute(
          builder: (_) => SugarDetailsView(
                sugarCenter: settings.arguments as SugarCenterEntity,
              ));
    case AddToListView.routeName:
      return MaterialPageRoute(builder: (_) => const AddToListView());
    case ChooseDistrictView.routeName:
      return MaterialPageRoute(builder: (_) => const ChooseDistrictView());
    case MedicalArticlesView.routeName:
      return MaterialPageRoute(builder: (_) => MedicalArticlesView());
    case GlucoseReportView.routeName:
      return MaterialPageRoute(builder: (_) => GlucoseReportView());
    case ProfileView.routeName:
      return MaterialPageRoute(builder: (_) => ProfileView());
    case EditProfileView.routeName:
      return MaterialPageRoute(builder: (_) => EditProfileView());
    //Admin routes
    case AdminHomeView.routeName:
      return MaterialPageRoute(builder: (_) => const AdminHomeView());
    case ManageSugarCenterView.routeName:
      return MaterialPageRoute(builder: (_) => ManageSugarCenterView());
    case AddSugarCenterView.routeName:
      return MaterialPageRoute(builder: (_) => AddSugarCenterView());
    case DeleteSugarCenterView.routeName:
      return MaterialPageRoute(
          builder: (_) => DeleteSugarCenterView(
                sugarCenter: settings.arguments as SugarCenterEntity,
              ),
      );
    case ManageEmergencyNumberView.routeName:
      return MaterialPageRoute(builder: (_) => ManageEmergencyNumberView());
    case AddEmergencyNumberView.routeName:
      return MaterialPageRoute(builder: (_) => AddEmergencyNumberView());
    case ManageArticlesView.routeName:
      return MaterialPageRoute(builder: (_) => ManageArticlesView());
    case AddArticleView.routeName:
      return MaterialPageRoute(builder: (_) => AddArticleView());
    case RefreshApiView.routeName:
      return MaterialPageRoute(builder: (_) => const RefreshApiView());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
