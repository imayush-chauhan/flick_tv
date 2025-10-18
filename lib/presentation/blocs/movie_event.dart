abstract class MovieEvent {}

class LoadMoviesEvent extends MovieEvent {}

class LoadMovieDetailsEvent extends MovieEvent {
  final String movieId;
  LoadMovieDetailsEvent(this.movieId);
}

class SearchMoviesEvent extends MovieEvent {
  final String query;
  SearchMoviesEvent(this.query);
}