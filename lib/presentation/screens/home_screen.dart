import 'package:flick_tv/domain/entities/movie.dart';
import 'package:flick_tv/presentation/blocs/movie_event.dart';
import 'package:flick_tv/presentation/blocs/movie_state.dart';
import 'package:flick_tv/presentation/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/movie_bloc.dart';
import '../widgets/featured_banner.dart';
import '../widgets/movie_row.dart';
import '../widgets/netflix_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFE50914)),
              );
            }
        
            if (state is MovieError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<MovieBloc>().add(LoadMoviesEvent());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
        
            if (state is MovieLoaded) {
              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: FlickTvAppBar()),
                  SliverToBoxAdapter(
                    child: FeaturedBanner(
                      movie: state.netflixOriginals.first,
                      onTap: () => _navigateToDetails(context, state.netflixOriginals.first),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: MovieRow(
                      title: 'FlickTv Originals',
                      movies: state.netflixOriginals,
                      onMovieTap: (movie) => _navigateToDetails(context, movie),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: MovieRow(
                      title: 'Trending Now',
                      movies: state.trendingMovies,
                      onMovieTap: (movie) => _navigateToDetails(context, movie),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: MovieRow(
                      title: 'Popular on FlickTv',
                      movies: state.popularMovies,
                      onMovieTap: (movie) => _navigateToDetails(context, movie),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: MovieRow(
                      title: 'Top Rated',
                      movies: state.topRated,
                      onMovieTap: (movie) => _navigateToDetails(context, movie),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 50)),
                ],
              );
            }
        
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context, Movie movie) {
    context.push(RouteNames.detail, extra: movie);
  }
}