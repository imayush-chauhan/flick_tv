import 'package:flick_tv/domain/entities/movie.dart';

class MovieRemoteDataSource {
  List<Movie> getMockMovies() {
    return [
      Movie(
        id: '1',
        title: 'Stranger Things',
        imageUrl: 'https://image.tmdb.org/t/p/w500/49WJfeN0moxb9IPfGn8AIqMGskD.jpg',
        bannerUrl: 'https://image.tmdb.org/t/p/original/56v2KjBlU4XaOv9rVYEQypROD7P.jpg',
        rating: 8.7,
        year: 2023,
        duration: '51m',
        genres: ['Sci-Fi', 'Horror', 'Drama'],
        description: 'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces and one strange little girl.',
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
        trailerUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
      ),
      Movie(
        id: '2',
        title: 'The Witcher',
        imageUrl: 'https://image.tmdb.org/t/p/w500/7vjaCdMw15FEbXyLQTVa04URsPm.jpg',
        bannerUrl: 'https://image.tmdb.org/t/p/w500/7vjaCdMw15FEbXyLQTVa04URsPm.jpg',
        rating: 8.2,
        year: 2023,
        duration: '60m',
        genres: ['Fantasy', 'Action', 'Adventure'],
        description: 'Geralt of Rivia, a solitary monster hunter, struggles to find his place in a world where people often prove more wicked than beasts.',
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
        trailerUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
      ),
      Movie(
        id: '3',
        title: 'Wednesday',
        imageUrl: 'https://image.tmdb.org/t/p/w500/9PFonBhy4cQy7Jz20NpMygczOkv.jpg',
        bannerUrl: 'https://image.tmdb.org/t/p/original/iHSwvRVsRyxpX7FE7GbviaDvgGZ.jpg',
        rating: 8.1,
        year: 2023,
        duration: '45m',
        genres: ['Comedy', 'Mystery', 'Fantasy'],
        description: 'Wednesday Addams is sent to Nevermore Academy, a bizarre boarding school where she attempts to master her psychic powers.',
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
        trailerUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
      ),
      Movie(
        id: '4',
        title: 'Dark',
        imageUrl: 'https://upload.wikimedia.org/wikipedia/en/thumb/d/da/DarkNetflixPosterEnglish.jpg/250px-DarkNetflixPosterEnglish.jpg',
        bannerUrl: 'https://upload.wikimedia.org/wikipedia/en/thumb/d/da/DarkNetflixPosterEnglish.jpg/250px-DarkNetflixPosterEnglish.jpg',
        rating: 8.8,
        year: 2023,
        duration: '58m',
        genres: ['Mystery', 'Drama', 'Sci-Fi'],
        description: 'A family saga with a supernatural twist, set in a German town where the disappearance of two young children exposes the relationships among four families.',
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
        trailerUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
      ),
      Movie(
        id: '5',
        title: 'Money Heist',
        imageUrl: 'https://resizing.flixster.com/ITt1FPrFePNR6FSqZrZK7BocG2U=/ems.cHJkLWVtcy1hc3NldHMvdHZzZWFzb24vUlRUVjEwMTMyOTMud2VicA==',
        bannerUrl: 'https://resizing.flixster.com/ITt1FPrFePNR6FSqZrZK7BocG2U=/ems.cHJkLWVtcy1hc3NldHMvdHZzZWFzb24vUlRUVjEwMTMyOTMud2VicA==',
        rating: 8.3,
        year: 2023,
        duration: '70m',
        genres: ['Crime', 'Action', 'Thriller'],
        description: 'An unusual group of robbers attempt to carry out the most perfect robbery in Spanish history - stealing 2.4 billion euros from the Royal Mint of Spain.',
        videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
        trailerUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
      ),
    ];
  }

  Future<List<Movie>> fetchTrendingMovies() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return getMockMovies();
  }

  Future<List<Movie>> fetchPopularMovies() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return getMockMovies().reversed.toList();
  }

  Future<List<Movie>> fetchTopRated() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return getMockMovies();
  }

  Future<List<Movie>> fetchNetflixOriginals() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return getMockMovies();
  }

  Future<Movie> fetchMovieDetails(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return getMockMovies().firstWhere((m) => m.id == id);
  }

  Future<List<Movie>> fetchSimilarMovies(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return getMockMovies().where((m) => m.id != id).toList();
  }
}