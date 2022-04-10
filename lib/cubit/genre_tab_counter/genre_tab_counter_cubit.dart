import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class GenreTabCounterCubit extends Cubit<int> {
  GenreTabCounterCubit() : super(0);
  void change(int index) {
    emit(index);
  }
}
