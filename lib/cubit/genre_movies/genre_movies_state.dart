part of 'genre_movies_cubit.dart';

abstract class GenreMoviesState extends Equatable {
  const GenreMoviesState();

  @override
  List<Object> get props => [];
}

class GenreMoviesLoading extends GenreMoviesState {}

class GenreMoviesLoaded extends GenreMoviesState {
  final List<Movie> movies;
  const GenreMoviesLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class GenreMoviesError extends GenreMoviesState {
  final String message;
  const GenreMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
