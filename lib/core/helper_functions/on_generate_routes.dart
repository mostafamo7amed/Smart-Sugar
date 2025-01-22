import 'package:flutter/material.dart';
import 'package:smart_sugar/features/splash/presentation/view/splash_view.dart';

import '../../features/auth/presentation/views/forget_password_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/on_boarding_view.dart';
import '../../features/auth/presentation/views/register_view.dart';
import '../../features/home/presentation/view/home_view.dart';
import '../../features/home/presentation/view/user_home_root.dart';

Route<dynamic> onGenerateRoute (RouteSettings settings){
  switch(settings.name){
    case  SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case  LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case  RegisterView.routeName:
      return MaterialPageRoute(builder: (_) => const RegisterView());
    case  OnBoardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());
    case  ForgetPasswordView.routeName:
      return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
    case  HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case  UserHomeRoot.routeName:
      return MaterialPageRoute(builder: (_) => const UserHomeRoot());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}