import 'package:flick_tv/domain/entities/movie.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> trendingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRated;
  final List<Movie> netflixOriginals;

  MovieLoaded({
    required this.trendingMovies,
    required this.popularMovies,
    required this.topRated,
    required this.netflixOriginals,
  });
}

class MovieDetailsLoaded extends MovieState {
  final Movie movie;
  final List<Movie> similarMovies;

  MovieDetailsLoaded({
    required this.movie,
    required this.similarMovies,
  });
}

class MovieError extends MovieState {
  final String message;
  MovieError(this.message);
}