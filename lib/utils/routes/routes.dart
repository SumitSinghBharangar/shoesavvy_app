import 'package:flutter/material.dart';
import 'package:shoesavvy_app/screens/admin-panel/admin-panel-mainscreen.dart';
import 'package:shoesavvy_app/screens/auth-ui/pageroot.dart';
import 'package:shoesavvy_app/screens/auth-ui/welcome-screen.dart';
import 'package:shoesavvy_app/screens/user-panel/trial-mainscreen.dart';

import '../../screens/auth-ui/splash-screen.dart';
import '../../screens/user-panel/main-screen.dart';
import 'route-name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.mainscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MainScreen());

      case RouteName.root:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AuthenticationScreen());

      case RouteName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case RouteName.welcome:
        return MaterialPageRoute(
            builder: (BuildContext context) => const WelcomeScreen());
      case RouteName.adminscreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AdminNameScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No Routs Defined"),
            ),
          );
        });
    }
  }
}
