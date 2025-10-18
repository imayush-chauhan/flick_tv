import 'package:flick_tv/domain/entities/movie.dart';
import 'package:flick_tv/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';

class MovieRow extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final Function(Movie) onMovieTap;

  const MovieRow({
    Key? key,
    required this.title,
    required this.movies,
    required this.onMovieTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 12 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 40),
            child: Text(
              title,
              style: TextStyle(
                fontSize: isMobile ? 18 : 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 8 : 12),
          SizedBox(
            height: isMobile ? 140 : 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 36),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return MovieCard(
                  movie: movies[index],
                  onTap: () => onMovieTap(movies[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}