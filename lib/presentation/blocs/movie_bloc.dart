import 'package:flick_tv/domain/usecases/get_movie_details.dart';
import 'package:flick_tv/domain/usecases/get_movies.dart';
import 'package:flick_tv/presentation/blocs/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_event.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovies getMovies;
  final GetMovieDetails getMovieDetails;

  MovieBloc(this.getMovies, this.getMovieDetails) : super(MovieInitial()) {
    on<LoadMoviesEvent>(_onLoadMovies);
    on<LoadMovieDetailsEvent>(_onLoadMovieDetails);
  }

  Future<void> _onLoadMovies(
      LoadMoviesEvent event,
      Emitter<MovieState> emit,
      ) async {
    emit(MovieLoading());
    try {
      final trending = await getMovies.getTrending();
      final popular = await getMovies.getPopular();
      final topRated = await getMovies.getTopRated();
      final originals = await getMovies.getNetflixOriginals();

      emit(MovieLoaded(
        trendingMovies: trending,
        popularMovies: popular,
        topRated: topRated,
        netflixOriginals: originals,
      ));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  Future<void> _onLoadMovieDetails(
      LoadMovieDetailsEvent event,
      Emitter<MovieState> emit,
      ) async {
    emit(MovieLoading());
    try {
      final movie = await getMovieDetails(event.movieId);
      final similar = await getMovieDetails.getSimilar(event.movieId);

      emit(MovieDetailsLoaded(
        movie: movie,
        similarMovies: similar,
      ));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }
}