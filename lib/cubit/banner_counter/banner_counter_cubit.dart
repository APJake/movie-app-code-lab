import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class BannerCounterCubit extends Cubit<double> {
  BannerCounterCubit() : super(0);

  void change(double index) => emit(index);
}
