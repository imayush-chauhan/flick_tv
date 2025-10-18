class Movie {
  final String id;
  final String title;
  final String imageUrl;
  final String bannerUrl;
  final double rating;
  final int year;
  final String duration;
  final List<String> genres;
  final String description;
  final String videoUrl;
  final String trailerUrl;

  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.bannerUrl,
    required this.rating,
    required this.year,
    required this.duration,
    required this.genres,
    required this.description,
    required this.videoUrl,
    required this.trailerUrl,
  });
}