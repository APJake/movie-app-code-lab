import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/ui/model/movie_detail_ui.dart';

import '../../data/repository/movie_repository.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final MovieRepository _movieRepository;
  MovieDetailCubit(this._movieRepository) : super(MovieDetailLoading());

  void loadMovie(int movieId) {
    emit(MovieDetailLoading());
    _movieRepository.getMovieDetail(movieId).then((value) {
      emit(MovieDetailLoaded(movie: value));
    }).catchError((e) {
      if (e is DioError) {
        emit(MovieDetailError(e.message));
      } else {
        emit(const MovieDetailError("Something went wrong"));
      }
    });
  }
}
