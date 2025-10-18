import 'package:flick_tv/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getTrendingMovies();
  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> getTopRated();
  Future<List<Movie>> getNetflixOriginals();
  Future<Movie> getMovieDetails(String id);
  Future<List<Movie>> getSimilarMovies(String id);
}