import 'package:flick_tv/domain/entities/movie.dart';
import 'package:flick_tv/domain/repositories/movie_repository.dart';

class GetMovies {
  final MovieRepository repository;

  GetMovies(this.repository);

  Future<List<Movie>> getTrending() => repository.getTrendingMovies();
  Future<List<Movie>> getPopular() => repository.getPopularMovies();
  Future<List<Movie>> getTopRated() => repository.getTopRated();
  Future<List<Movie>> getNetflixOriginals() => repository.getNetflixOriginals();
}