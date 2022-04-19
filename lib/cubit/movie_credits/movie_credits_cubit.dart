import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/model/response_credits.dart';

import '../../data/repository/movie_repository.dart';

part 'movie_credits_state.dart';

class MovieCreditsCubit extends Cubit<MovieCreditsState> {
  final MovieRepository _repository;
  final int movieId;
  MovieCreditsCubit(this._repository, {required this.movieId})
      : super(MovieCreditsLoading()) {
    loadCredits(movieId);
  }

  void loadCredits(int movieId) {
    emit(MovieCreditsLoading());
    _repository.getCredits(movieId).then((value) {
      emit(MovieCreditsLoaded(credits: value));
    }).catchError((e) {
      if (e is DioError) {
        emit(MovieCreditsError(e.message));
      } else {
        emit(const MovieCreditsError("Something went wrong"));
      }
    });
  }
}
