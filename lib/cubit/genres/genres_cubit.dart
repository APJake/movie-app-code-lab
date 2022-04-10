import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/model/genre.dart';
import 'package:movie_app/data/repository/movie_repository.dart';

part 'genres_state.dart';

class GenresCubit extends Cubit<GenresState> {
  final MovieRepository _repository;
  GenresCubit(this._repository) : super(GenresLoading());

  void loadGenres() {
    emit(GenresLoading());
    _repository.getGenres().then((value) {
      emit(GenresLoaded(genres: value));
    }).catchError((e) {
      if (e is DioError) {
        emit(GenresError(e.message));
      } else {
        emit(const GenresError("Something went wrong"));
      }
    });
  }
}
