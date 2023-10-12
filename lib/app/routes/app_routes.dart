import 'package:book/app/modules/home_page/view/home_view.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const HomeView());

      default:
        return MaterialPageRoute(builder: (context) => const HomeView());
    }
  }
}
