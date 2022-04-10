part of 'top_rated_movies_cubit.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class TopRatedLoading extends TopRatedMoviesState {}

class TopRatedLoaded extends TopRatedMoviesState {
  final List<Movie> movies;
  const TopRatedLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class TopRatedError extends TopRatedMoviesState {
  final String message;
  const TopRatedError(this.message);

  @override
  List<Object> get props => [message];
}
