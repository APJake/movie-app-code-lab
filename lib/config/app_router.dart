import 'package:flutter/material.dart';
import 'package:movie_app/data/model/movie.dart';

import '../ui/screens/home_screen.dart';
import '../ui/screens/movie_detail_screen.dart';

class AppRouter {
  static Route onGenerateroute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case HomeScreen.routeName:
        return HomeScreen.route();
      case MovieDetailScreen.routeName:
        if (arguments is Movie) {
          return MovieDetailScreen.route(arguments);
        } else {
          return _errorRoute();
        }
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("Routing Error"),
              ),
            ),
        settings: const RouteSettings(name: "/error"));
  }
}
