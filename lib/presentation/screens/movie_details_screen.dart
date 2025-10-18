import 'package:flick_tv/domain/entities/movie.dart';
import 'package:flick_tv/presentation/blocs/movie_event.dart';
import 'package:flick_tv/presentation/blocs/movie_state.dart';
import 'package:flick_tv/presentation/routes/route_names.dart';
import 'package:flick_tv/presentation/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/movie_bloc.dart';
import '../widgets/movie_card.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(
        context.read<MovieBloc>().getMovies,
        context.read<MovieBloc>().getMovieDetails,
      )..add(LoadMovieDetailsEvent(movie.id)),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFFE50914)),
                );
              }
          
              if (state is MovieDetailsLoaded || true) {
                final currentMovie = state is MovieDetailsLoaded ? state.movie : movie;
                final similarMovies = state is MovieDetailsLoaded ? state.similarMovies : <Movie>[];
          
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _buildVideoSection(context, currentMovie),
                    ),
                    SliverToBoxAdapter(
                      child: _buildDetailsSection(context, currentMovie),
                    ),
                    if (similarMovies.isNotEmpty)
                      SliverToBoxAdapter(
                        child: _buildSimilarMoviesSection(context, similarMovies),
                      ),
                    const SliverToBoxAdapter(child: SizedBox(height: 50)),
                  ],
                );
              }
          
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildVideoSection(BuildContext context, Movie movie) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final height = isMobile ? 250.0 : 600.0;

    return SizedBox(
      height: height,
      child: VideoPlayersWidget(
        videoUrl: movie.trailerUrl,
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context, Movie movie) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: isMobile ? 1 : 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontSize: isMobile ? 28 : 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[600]!),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            '${movie.year}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${movie.rating}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Text(
                          movie.duration,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: movie.genres.map((genre) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            genre,
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      movie.description,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        height: 1.6,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _playFullMovie(context, movie);
                            },
                            icon: const Icon(Icons.play_arrow, size: 28),
                            label: const Text(
                              'Play',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE50914),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                vertical: isMobile ? 12 : 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add, size: 28),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.thumb_up_outlined, size: 24),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share_outlined, size: 24),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isMobile) const SizedBox(width: 40),
              if (!isMobile)
                Expanded(
                  flex: 1,
                  child: _buildInfoCard(movie),
                ),
            ],
          ),
          if (isMobile) ...[
            const SizedBox(height: 32),
            _buildInfoCard(movie),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoCard(Movie movie) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Cast', 'Various Artists'),
          const Divider(height: 24, color: Colors.grey),
          _buildInfoRow('Genres', movie.genres.join(', ')),
          const Divider(height: 24, color: Colors.grey),
          _buildInfoRow('This show is', 'Exciting, Suspenseful, Dark'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildSimilarMoviesSection(BuildContext context, List<Movie> movies) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'More Like This',
            style: TextStyle(
              fontSize: isMobile ? 20 : 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount;
              if (constraints.maxWidth > 1200) {
                crossAxisCount = 6;
              } else if (constraints.maxWidth > 800) {
                crossAxisCount = 4;
              } else if (constraints.maxWidth > 600) {
                crossAxisCount = 3;
              } else {
                crossAxisCount = 2;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return MovieCard(
                    movie: movies[index],
                    onTap: () {
                      context.pushReplacement(RouteNames.detail, extra: movies[index]);
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _playFullMovie(BuildContext context, Movie movie) {
    context.push(RouteNames.video, extra: {
      "videoUrl": movie.videoUrl,
      "autoPlay": true,
    });
  }
}