import 'package:flutter/material.dart';
import 'package:smart_sugar/features/splash/presentation/view/splash_view.dart';

import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/register_view.dart';
import '../../features/home/peresentation/view/home_view.dart';

Route<dynamic> onGenerateRoute (RouteSettings settings){
  switch(settings.name){
    case  SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case  LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case  RegisterView.routeName:
      return MaterialPageRoute(builder: (_) => const RegisterView());
    case  HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}