import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubit/popular_movies/popular_movies_cubit.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/ui/widgets/components/error_view.dart';
import 'package:movie_app/ui/widgets/components/loading_view.dart';
import 'package:movie_app/ui/widgets/components/small_text.dart';
import 'package:movie_app/ui/widgets/movie_item.dart';

import '../../config/app_config.dart';
import '../theme.dart';

class PopularSession extends StatelessWidget {
  const PopularSession({Key? key}) : super(key: key);

  static late double _screenWidth;

  _movieList(List<Movie> movies) => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: ((context, index) => MovieItem(movies[index])),
        itemCount: movies.length,
        scrollDirection: Axis.horizontal,
      );

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    getIt.call<PopularMoviesCubit>().loadMovies();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SmallText(
            "BEST POPULAR FILMS AND SERIES",
            size: AppSizes.xSmallFont,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: _screenWidth,
          height: AppSizes.movieItemHeight,
          child: BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
            builder: (context, state) {
              if (state is PopularLoading) {
                return const LoadingView();
              }
              if (state is PopularLoaded) {
                return _movieList(state.movies);
              }
              if (state is PopularError) {
                return ErrorView(message: state.message);
              }
              return const ErrorView();
            },
          ),
        ),
      ],
    );
  }
}
