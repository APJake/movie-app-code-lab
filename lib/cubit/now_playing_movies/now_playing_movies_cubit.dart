import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/data/repository/movie_repository.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  final MovieRepository _movieRepository;
  NowPlayingMoviesCubit(this._movieRepository) : super(NowPlayingLoading());

  void loadMovies() {
    emit(NowPlayingLoading());
    _movieRepository.getNowPlayingMovies().then((value) {
      emit(NowPlayingLoaded(movies: value));
    }).catchError((e) {
      if (e is DioError) {
        emit(NowPlayingError(e.message));
      } else {
        emit(const NowPlayingError("Something went wrong"));
      }
    });
  }
}
