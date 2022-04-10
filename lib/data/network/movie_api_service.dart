import 'package:dio/dio.dart';
import 'package:movie_app/data/model/movie_detail.dart';
import 'package:movie_app/data/model/response_credits.dart';
import 'package:movie_app/data/model/response_genres.dart';
import 'package:movie_app/data/model/response_movies.dart';
import 'package:movie_app/data/model/response_popular_actors.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_api_service.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3/")
abstract class MovieApiService {
  factory MovieApiService(Dio dio) = _MovieApiService;

  @GET("/movie/now_playing")
  Future<ResponseMovies> getNowPlayingMovies(
    @Query("api_key") String apiKey,
  );

  @GET("/movie/popular")
  Future<ResponseMovies> getBestMovies(
    @Query("api_key") String apiKey,
  );

  @GET("/movie/top_rated")
  Future<ResponseMovies> getTopRatedMovies(
    @Query("api_key") String apiKey,
  );

  @GET("/discover/movie")
  Future<ResponseMovies> getMoviesByGenre(
    @Query("api_key") String apiKey,
    @Query("with_genres") int genreId,
  );

  @GET("/movie/{movie_id}")
  Future<MovieDetail> getMovieDetail(
    @Query("api_key") String apiKey,
    @Path("movie_id") int movieId,
  );

  @GET("/person/popular")
  Future<ResponsePopularActors> getBestActors(
    @Query("api_key") String apiKey,
  );

  @GET("/movie/{movie_id}/credits")
  Future<ResponseCredits> getCredits(
      @Query("api_key") String apiKey, @Path("movie_id") int movieId);

  @GET("/genre/movie/list")
  Future<ResponseGenres> getGenres(
    @Query("api_key") String apiKey,
  );
}
