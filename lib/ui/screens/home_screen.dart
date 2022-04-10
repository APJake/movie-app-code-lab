import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/app_config.dart';
import 'package:movie_app/cubit/best_actors/best_actors_cubit.dart';
import 'package:movie_app/cubit/genre_movies/genre_movies_cubit.dart';
import 'package:movie_app/cubit/genres/genres_cubit.dart';
import 'package:movie_app/cubit/popular_movies/popular_movies_cubit.dart';
import 'package:movie_app/cubit/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movie_app/ui/theme.dart';
import 'package:movie_app/ui/widgets/banner_session.dart';
import 'package:movie_app/ui/widgets/best_actor_session.dart';
import 'package:movie_app/ui/widgets/check_movie_showtime_session.dart';
import 'package:movie_app/ui/widgets/show_case_session.dart';
import '../../../cubit/banner_counter/banner_counter_cubit.dart';
import '../../../cubit/now_playing_movies/now_playing_movies_cubit.dart';
import '../widgets/genres_and_movies_session.dart';
import '../widgets/popular_session.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/";
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const HomeScreen(),
    );
  }

  static double _screenWidth = 0;

  const HomeScreen({Key? key}) : super(key: key);

  _appBar() => AppBar(
        title: const Text("Discover"),
        leading: IconButton(
            icon: const Icon(Icons.format_align_left_rounded),
            onPressed: () {}),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
        elevation: 0,
        backgroundColor: AppColors.background,
      );

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: _appBar(),
        backgroundColor: AppColors.background,
        body: MultiBlocProvider(
            providers: [
              BlocProvider<NowPlayingMoviesCubit>(
                create: (context) => getIt.call(),
              ),
              BlocProvider<BannerCounterCubit>(
                create: (context) => getIt.call(),
              ),
              BlocProvider<PopularMoviesCubit>(
                create: (context) => getIt.call(),
              ),
              BlocProvider<GenresCubit>(
                create: (context) => getIt.call(),
              ),
              BlocProvider<GenreMoviesCubit>(
                create: (context) => getIt.call(),
              ),
              BlocProvider<TopRatedMoviesCubit>(
                create: (context) => getIt.call(),
              ),
              BlocProvider<BestActorsCubit>(
                create: (context) => getIt.call(),
              ),
            ],
            child: SingleChildScrollView(
              child: SizedBox(
                width: _screenWidth,
                child: Column(
                  children: const [
                    BannerSession(),
                    SizedBox(height: 10),
                    PopularSession(),
                    SizedBox(height: 10),
                    CheckMovieShowTimeSession(),
                    SizedBox(height: 30),
                    GenresAndMoviesSession(),
                    ShowCaseSession(),
                    BestActorSession(),
                  ],
                ),
              ),
            )));
  }
}
