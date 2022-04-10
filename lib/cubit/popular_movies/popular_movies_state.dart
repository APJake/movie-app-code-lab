part of 'popular_movies_cubit.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class PopularLoading extends PopularMoviesState {}

class PopularLoaded extends PopularMoviesState {
  final List<Movie> movies;
  const PopularLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class PopularError extends PopularMoviesState {
  final String message;
  const PopularError(this.message);

  @override
  List<Object> get props => [message];
}
