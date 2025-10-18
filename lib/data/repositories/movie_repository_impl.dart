import 'package:flick_tv/data/datasources/movie_remote_datasource.dart';
import 'package:flick_tv/domain/entities/movie.dart';
import 'package:flick_tv/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource dataSource;

  MovieRepositoryImpl(this.dataSource);

  @override
  Future<List<Movie>> getTrendingMovies() => dataSource.fetchTrendingMovies();

  @override
  Future<List<Movie>> getPopularMovies() => dataSource.fetchPopularMovies();

  @override
  Future<List<Movie>> getTopRated() => dataSource.fetchTopRated();

  @override
  Future<List<Movie>> getNetflixOriginals() => dataSource.fetchNetflixOriginals();

  @override
  Future<Movie> getMovieDetails(String id) => dataSource.fetchMovieDetails(id);

  @override
  Future<List<Movie>> getSimilarMovies(String id) => dataSource.fetchSimilarMovies(id);
}