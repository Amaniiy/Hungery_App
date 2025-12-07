import 'package:flutter/material.dart';
import 'package:sonic_app/core/routing/Routes.dart';
import 'package:sonic_app/features/auth/login/ui/login_ui.dart';
import 'package:sonic_app/features/auth/signup/ui/signup.dart';
import 'package:sonic_app/root.dart';
import 'package:sonic_app/splash.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => const Signup());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.roots:
        return MaterialPageRoute(builder: (_) => const Root());
    }
  }
}
