part of 'now_playing_movies_cubit.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class NowPlayingLoading extends NowPlayingMoviesState {}

class NowPlayingLoaded extends NowPlayingMoviesState {
  final List<Movie> movies;
  const NowPlayingLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class NowPlayingError extends NowPlayingMoviesState {
  final String message;
  const NowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}
