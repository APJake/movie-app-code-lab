import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/movie.dart';
import '../../data/repository/movie_repository.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final MovieRepository _movieRepository;
  PopularMoviesCubit(this._movieRepository) : super(PopularLoading());

  void loadMovies() {
    emit(PopularLoading());
    _movieRepository.getBestMovies().then((value) {
      emit(PopularLoaded(movies: value));
    }).catchError((e) {
      if (e is DioError) {
        emit(PopularError(e.message));
      } else {
        emit(const PopularError("Something went wrong"));
      }
    });
  }
}
