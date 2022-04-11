import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubit/genre_movies/genre_movies_cubit.dart';
import 'package:movie_app/cubit/genres/genres_cubit.dart';
import 'package:movie_app/ui/theme.dart';
import 'package:movie_app/ui/widgets/movie_item.dart';
import '../../config/app_config.dart';
import '../../data/model/genre.dart';
import '../../data/model/movie.dart';
import 'components/error_view.dart';
import 'components/loading_view.dart';

class GenresAndMoviesSession extends StatefulWidget {
  const GenresAndMoviesSession({Key? key}) : super(key: key);

  @override
  State<GenresAndMoviesSession> createState() => _GenresAndMoviesSessionState();
}

class _GenresAndMoviesSessionState extends State<GenresAndMoviesSession>
    with TickerProviderStateMixin {
  static late TabController _tabController;

  static late double _screenWidth;

  _movieList(List<Movie> movies) => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: ((context, index) => MovieItem(movies[index])),
        itemCount: movies.length,
        scrollDirection: Axis.horizontal,
      );

  _moviesView() {
    return Container(
      width: _screenWidth,
      height: AppSizes.movieItemHeight + 35,
      padding: const EdgeInsets.only(top: 20),
      color: AppColors.backgroundDark,
      child: BlocBuilder<GenreMoviesCubit, GenreMoviesState>(
        builder: (context, state) {
          if (state is GenreMoviesLoading) {
            return const LoadingView();
          }
          if (state is GenreMoviesLoaded) {
            return _movieList(state.movies);
          }
          if (state is GenreMoviesError) {
            return ErrorView(message: state.message);
          }
          return const ErrorView(message: "Something went wrong");
        },
      ),
    );
  }

  _tabbar(List<Genre> genres) {
    _tabController =
        TabController(length: genres.length, vsync: this, initialIndex: 0);
    BlocProvider.of<GenreMoviesCubit>(context)
        .loadMovies(genreId: genres[0].id);

    return TabBar(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      controller: _tabController,
      isScrollable: true,
      onTap: (index) => BlocProvider.of<GenreMoviesCubit>(context)
          .loadMovies(genreId: genres[index].id),
      unselectedLabelColor: AppColors.hint,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(width: 3.0, color: AppColors.primary),
        insets: EdgeInsets.symmetric(horizontal: 10.0),
      ),
      tabs: genres
          .map(
            (genre) => Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(genre.name),
            ),
          )
          .toList(),
    );
  }

  _body(List<Genre> genres) => Column(
        children: [_tabbar(genres), _moviesView()],
      );

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    getIt.call<GenresCubit>().loadGenres();
    return BlocBuilder<GenresCubit, GenresState>(
      builder: (context, state) {
        if (state is GenresLoading) {
          return const LoadingView();
        }
        if (state is GenresLoaded) {
          return _body(state.genres);
        }
        if (state is GenresError) {
          return ErrorView(message: state.message);
        }
        return const ErrorView(message: "Something went wrong");
      },
    );
  }
}
