import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/model/cast.dart';

import '../../data/repository/movie_repository.dart';

part 'best_actors_state.dart';

class BestActorsCubit extends Cubit<BestActorsState> {
  final MovieRepository _repository;
  BestActorsCubit(this._repository) : super(BestActorsLoading());

  void loadCasts() {
    emit(BestActorsLoading());
    _repository.getBestActors().then((value) {
      emit(BestActorsLoaded(casts: value));
    }).catchError((e) {
      throw e;
      if (e is DioError) {
        emit(BestActorsError(e.message));
      } else {
        emit(const BestActorsError("Something went wrong"));
      }
    });
  }
}
