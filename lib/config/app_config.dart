import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/cubit/banner_counter/banner_counter_cubit.dart';
import 'package:movie_app/cubit/best_actors/best_actors_cubit.dart';
import 'package:movie_app/cubit/genre_movies/genre_movies_cubit.dart';
import 'package:movie_app/cubit/genres/genres_cubit.dart';
import 'package:movie_app/cubit/movie_credits/movie_credits_cubit.dart';
import 'package:movie_app/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:movie_app/cubit/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movie_app/cubit/popular_movies/popular_movies_cubit.dart';
import 'package:movie_app/cubit/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movie_app/data/network/movie_api_service.dart';
import 'package:movie_app/data/repository/movie_repository.dart';
import 'package:movie_app/utils/navigation_service.dart';

var getIt = GetIt.I;

void locator() {
  Dio dio = Dio();
  // dio.interceptors.add(PrettyDioLogger());
  getIt.registerLazySingleton(() => dio);

  // navigation service
  getIt.registerLazySingleton(() => NavigationService());

  MovieApiService movieApiService = MovieApiService(getIt.call());
  getIt.registerLazySingleton(() => movieApiService);

  MovieRepository movieRepository = MovieRepository(getIt.call());
  getIt.registerLazySingleton(() => movieRepository);

  // HOME PAGE
  // for banner session
  getIt.registerLazySingleton(() => NowPlayingMoviesCubit(getIt.call()));
  getIt.registerLazySingleton(() => BannerCounterCubit());

  // for popular session
  getIt.registerLazySingleton(() => PopularMoviesCubit(getIt.call()));

  // for genre session
  getIt.registerLazySingleton(() => GenresCubit(getIt.call()));
  getIt.registerLazySingleton(() => GenreMoviesCubit(getIt.call()));

  // for showcase session
  getIt.registerLazySingleton(() => TopRatedMoviesCubit(getIt.call()));

  // for best actors session
  getIt.registerLazySingleton(() => BestActorsCubit(getIt.call()));

  // MOVIE DETAIL PAGE
  // movie detail
  getIt.registerLazySingleton(() => MovieDetailCubit(getIt.call()));
  getIt.registerLazySingleton(() => MovieCreditsCubit(getIt.call()));
}
