import 'package:movie_app/config/app_constants.dart';
import 'package:movie_app/data/model/response_credits.dart';
import 'package:movie_app/data/network/movie_api_service.dart';
import 'package:movie_app/data/model/cast.dart';
import 'package:movie_app/data/model/genre.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/ui/model/movie_detail_ui.dart';

class MovieRepository {
  final MovieApiService _apiService;

  MovieRepository(this._apiService);

  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await _apiService.getNowPlayingMovies(AppConstants.apiKey);

    return response.results;
  }

  Future<List<Movie>> getBestMovies() async {
    final response = await _apiService.getBestMovies(AppConstants.apiKey);
    return response.results;
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await _apiService.getTopRatedMovies(AppConstants.apiKey);
    return response.results;
  }

  Future<List<Movie>> getMoviesByGenre(int genreId) async {
    final response =
        await _apiService.getMoviesByGenre(AppConstants.apiKey, genreId);
    return response.results;
  }

  Future<List<Genre>> getGenres() async {
    final response = await _apiService.getGenres(AppConstants.apiKey);
    return response.genres;
  }

  Future<MovieDetailUi> getMovieDetail(int movieId) async {
    final response =
        await _apiService.getMovieDetail(AppConstants.apiKey, movieId);
    return MovieDetailUi.fromModel(response);
  }

  Future<List<Cast>> getBestActors() async {
    final response = await _apiService.getBestActors(AppConstants.apiKey);
    return response.results;
  }

  Future<ResponseCredits> getCredits(int movieId) async {
    final response = await _apiService.getCredits(AppConstants.apiKey, movieId);
    return response;
  }
}
