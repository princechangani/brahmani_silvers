
import 'package:brahmani_silvers/Screens/home%20screen/generate_bill_screen.dart';
import 'package:brahmani_silvers/Screens/login%20screen/login_screen.dart';
import 'package:brahmani_silvers/Screens/splash%20screen/bloc/splash_bloc.dart';
import 'package:brahmani_silvers/Screens/splash%20screen/splash_screen.dart';
import 'package:flutter/material.dart';




class Routes {
  static const String loginPage = '/login';
  static const String otp = '/otp';
  static const String forgotPasswordPage = '/forgotPassword';
  static const String facultyDashboard='facultyDashboard';
 // static const String student='student';
  static const String bottombar='bottombar';
  static const String studentDashboard='studentDashboard';

  static const String chat='chat';

  static const String course='course';

  static const String attendance='attendance';

  static const String exam='exam';
  static const String splash='splash';
  static const adminDashboard = "adminDashboard";
  static const manageSchedule = "manageSchedule";
  static const home = "home";




}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splash:
      return MaterialPageRoute(builder: (_) => SplashScreen());
    case Routes.loginPage:
      return MaterialPageRoute(builder: (_) =>LoginScreen());
    case Routes.home:
      return MaterialPageRoute(builder: (_) =>GenerateBillScreen());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('Route not found')),
        ),
      );
  }
}

