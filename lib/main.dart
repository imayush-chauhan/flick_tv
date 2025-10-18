import 'package:flick_tv/data/datasources/movie_remote_datasource.dart';
import 'package:flick_tv/data/repositories/movie_repository_impl.dart';
import 'package:flick_tv/domain/usecases/get_movie_details.dart';
import 'package:flick_tv/domain/usecases/get_movies.dart';
import 'package:flick_tv/presentation/blocs/movie_event.dart';
import 'package:flick_tv/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';
import 'presentation/blocs/movie_bloc.dart';

void main() {
  setPathUrlStrategy();
  runApp(const FlickTv());
}

class FlickTv extends StatelessWidget {
  const FlickTv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataSource = MovieRemoteDataSource();
    final repository = MovieRepositoryImpl(dataSource);
    final getMovies = GetMovies(repository);
    final getMovieDetails = GetMovieDetails(repository);

    return BlocProvider(
      create: (context) => MovieBloc(getMovies, getMovieDetails)
        ..add(LoadMoviesEvent()),
      child: MaterialApp.router(
        title: 'Flick Tv',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          primaryColor: const Color(0xFFE50914),
          fontFamily: 'Flick Tv',
        ),
      ),
    );
  }
}