part of 'best_actors_cubit.dart';

abstract class BestActorsState extends Equatable {
  const BestActorsState();

  @override
  List<Object> get props => [];
}

class BestActorsLoading extends BestActorsState {}

class BestActorsLoaded extends BestActorsState {
  final List<Cast> casts;
  const BestActorsLoaded({required this.casts});

  @override
  List<Object> get props => [casts];
}

class BestActorsError extends BestActorsState {
  final String message;
  const BestActorsError(this.message);

  @override
  List<Object> get props => [message];
}
