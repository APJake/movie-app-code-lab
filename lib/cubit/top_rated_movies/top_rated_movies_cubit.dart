import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/movie.dart';
import '../../data/repository/movie_repository.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  final MovieRepository _movieRepository;
  TopRatedMoviesCubit(this._movieRepository) : super(TopRatedLoading());

  void loadMovies() {
    emit(TopRatedLoading());
    _movieRepository.getBestMovies().then((value) {
      emit(TopRatedLoaded(movies: value));
    }).catchError((e) {
      if (e is DioError) {
        emit(TopRatedError(e.message));
      } else {
        emit(const TopRatedError("Something went wrong"));
      }
    });
  }
}
