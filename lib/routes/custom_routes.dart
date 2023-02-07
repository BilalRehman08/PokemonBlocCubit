import 'package:flutter/material.dart';
import 'package:pokemonapp/routes/route_names.dart';

import '../views/favorite_view.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/register_view.dart';
import '../views/splash_view.dart';

class CustomRoutes {
  static Route<dynamic> allRoutes(RouteSettings setting) {
    switch (setting.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case RouteNames.favorite:
        return MaterialPageRoute(builder: (_) => const Favoriteview());
    }
    return MaterialPageRoute(builder: (_) => const SplashView());
  }
}
