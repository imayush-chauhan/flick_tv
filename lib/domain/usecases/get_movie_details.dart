import 'package:flick_tv/domain/entities/movie.dart';
import 'package:flick_tv/domain/repositories/movie_repository.dart';

class GetMovieDetails {
  final MovieRepository repository;

  GetMovieDetails(this.repository);

  Future<Movie> call(String id) => repository.getMovieDetails(id);
  Future<List<Movie>> getSimilar(String id) => repository.getSimilarMovies(id);
}