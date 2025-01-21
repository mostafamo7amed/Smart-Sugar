import 'package:flutter/material.dart';

import '../../features/auth/presentation/login_view.dart';

Route<dynamic> onGenerateRoute (RouteSettings settings){
  switch(settings.name){
    case  LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}