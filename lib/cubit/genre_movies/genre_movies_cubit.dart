import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/model/movie.dart';

import '../../data/repository/movie_repository.dart';

part 'genre_movies_state.dart';

class GenreMoviesCubit extends Cubit<GenreMoviesState> {
  final MovieRepository _movieRepository;
  GenreMoviesCubit(this._movieRepository) : super(GenreMoviesLoading());

  void loadMovies({required int genreId}) {
    emit(GenreMoviesLoading());
    _movieRepository.getMoviesByGenre(genreId).then((value) {
      emit(GenreMoviesLoaded(movies: value));
    }).catchError((e) {
      if (e is DioError) {
        emit(GenreMoviesError(e.message));
      } else {
        emit(const GenreMoviesError("Something went wrong"));
      }
    });
  }
}
