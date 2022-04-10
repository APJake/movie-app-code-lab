part of 'movie_credits_cubit.dart';

abstract class MovieCreditsState extends Equatable {
  const MovieCreditsState();

  @override
  List<Object> get props => [];
}

class MovieCreditsLoading extends MovieCreditsState {}

class MovieCreditsLoaded extends MovieCreditsState {
  final ResponseCredits credits;
  const MovieCreditsLoaded({required this.credits});

  @override
  List<Object> get props => [credits];
}

class MovieCreditsError extends MovieCreditsState {
  final String message;
  const MovieCreditsError(this.message);

  @override
  List<Object> get props => [message];
}
