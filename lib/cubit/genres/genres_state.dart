part of 'genres_cubit.dart';

abstract class GenresState extends Equatable {
  const GenresState();

  @override
  List<Object> get props => [];
}

class GenresLoading extends GenresState {}

class GenresLoaded extends GenresState {
  final List<Genre> genres;
  const GenresLoaded({required this.genres});

  @override
  List<Object> get props => [genres];
}

class GenresError extends GenresState {
  final String message;
  const GenresError(this.message);

  @override
  List<Object> get props => [message];
}
