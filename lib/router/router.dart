import 'package:flutter/material.dart';
import 'package:todo/pages/add_form_page.dart';
import 'package:todo/pages/home_page.dart';

class AppRouter {
  AppRouter._();

  static const String home = 'home';
  static const String addPage = 'addPage';

  static Route<dynamic>? routes(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        );
      case addPage:
        return MaterialPageRoute(
          builder: (context) {
            return const AddTaskPage();
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        );
    }
  }
}
