import 'package:bloc/bloc.dart';

class BannerCounterCubit extends Cubit<double> {
  BannerCounterCubit() : super(0);

  void change(double index) => emit(index);
}
