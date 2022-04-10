import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubit/banner_counter/banner_counter_cubit.dart';
import 'package:movie_app/cubit/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movie_app/config/app_router.dart';
import 'package:movie_app/config/app_config.dart';
import 'package:movie_app/ui/screens/home_screen.dart';
import 'package:movie_app/utils/navigation_service.dart';

void main() {
  locator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    NavigationService _navigationService = getIt.call();

    return MaterialApp(
      title: 'Movie App',
      onGenerateRoute: AppRouter.onGenerateroute,
      initialRoute: HomeScreen.routeName,
      navigatorKey: _navigationService.navigatorKey,
    );
  }
}
