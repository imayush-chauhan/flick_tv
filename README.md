# FlickTv Clone - Flutter

A fully responsive FlickTv clone built with Flutter using Clean Architecture and BLoC state management pattern. Works seamlessly on Web, iOS, and Android.

## Features

✅ **Complete FlickTv UI Clone**
- Home screen with featured banner
- Multiple movie/series rows (Trending, Popular, Top Rated, FlickTv Originals)
- Movie/Series details screen with trailer autoplay
- Similar content suggestions
- Responsive design for mobile, tablet, and web

✅ **Video Player**
- Custom video player with full controls
- Play/Pause functionality
- Seek controls (forward/backward 10 seconds)
- Progress bar with time display
- Volume controls
- Fullscreen mode
- Mute/Unmute option

✅ **Clean Architecture**
- **Presentation Layer**: UI components, BLoC, screens
- **Domain Layer**: Entities, use cases, repository interfaces
- **Data Layer**: Repository implementations, data sources

✅ **BLoC State Management**
- `MovieBloc`: Handles movie data fetching and state
- `VideoPlayerBloc`: Manages video playback state
- Separation of concerns with events and states

✅ **Responsive Design**
- Mobile-first approach
- Tablet optimization
- Desktop/Web layout
- Adaptive UI components

## Project Structure

```
lib/
├── main.dart
├── domain/
│   ├── entities/
│   │   └── movie.dart
│   ├── repositories/
│   │   └── movie_repository.dart
│   └── usecases/
│       ├── get_movies.dart
│       └── get_movie_details.dart
├── data/
│   ├── datasources/
│   │   └── movie_remote_datasource.dart
│   └── repositories/
│       └── movie_repository_impl.dart
└── presentation/
    ├── blocs/
    │   ├── movie_bloc.dart
    │   ├── movie_event.dart
    │   ├── movie_state.dart
    │   ├── video_player_bloc.dart
    │   └── video_player_state.dart
    ├── screens/
    │   ├── home_screen.dart
    │   ├── movie_details_screen.dart
    │   └── fullscreen_video_player.dart
    └── widgets/
        ├── netflix_app_bar.dart
        ├── featured_banner.dart
        ├── movie_row.dart
        ├── movie_card.dart
        ├── video_player_widget.dart
        └── video_player_controls.dart
```

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)

### Installation

1. **Clone or create a new Flutter project**
   ```bash
   flutter create flick_tv
   cd flick_tv
   ```

2. **Replace the files**
    - Copy `main.dart` to `lib/main.dart`
    - Create the folder structure and add all files accordingly
    - Update `pubspec.yaml` with the provided dependencies

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the app**

   For mobile (iOS/Android):
   ```bash
   flutter run
   ```

   For web:
   ```bash
   flutter run -d chrome
   ```

   For desktop:
   ```bash
   flutter run -d windows  # or macos, linux
   ```

## Architecture Overview

### Clean Architecture Layers

**1. Domain Layer (Business Logic)**
- `entities/`: Core business objects (Movie)
- `repositories/`: Abstract repository interfaces
- `usecases/`: Business logic operations (GetMovies, GetMovieDetails)

**2. Data Layer**
- `datasources/`: Remote/local data sources
- `repositories/`: Concrete implementations of repository interfaces
- Currently uses mock data, can be easily replaced with real API calls

**3. Presentation Layer (UI)**
- `screens/`: Full page screens
- `widgets/`: Reusable UI components
- `blocs/`: State management with BLoC pattern

### BLoC Pattern

**MovieBloc**
- Events: `LoadMoviesEvent`, `LoadMovieDetailsEvent`, `SearchMoviesEvent`
- States: `MovieInitial`, `MovieLoading`, `MovieLoaded`, `MovieDetailsLoaded`, `MovieError`

**VideoPlayerBloc**
- Events: `InitializeVideoEvent`, `PlayVideoEvent`, `PauseVideoEvent`, `SeekVideoEvent`, etc.
- States: `VideoPlayerInitial`, `VideoPlayerLoading`, `VideoPlayerReady`, `VideoPlayerError`

## Features Breakdown

### Home Screen
- Netflix-style app bar with navigation
- Featured banner with auto-playing preview
- Multiple scrollable movie rows
- Hover effects on desktop
- Responsive grid layout

### Movie Details Screen
- Auto-playing trailer at the top
- Movie information (title, rating, duration, genres)
- Description and metadata
- Action buttons (Play, Add to List, Like, Share)
- "More Like This" section with similar content
- Smooth navigation between movies

### Video Player
- Custom controls overlay
- Play/Pause button
- Seek functionality (±10 seconds)
- Progress bar with draggable scrubber
- Time display (current/total)
- Volume controls
- Fullscreen toggle
- Back button to return
- Auto-hide controls

## Customization

### Adding Real API Integration

Replace the mock data in `movie_remote_datasource.dart`:

```dart
class MovieRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'YOUR_API_KEY';

  Future<List<Movie>> fetchTrendingMovies() async {
    final response = await client.get(
      Uri.parse('$baseUrl/trending/all/week?api_key=$apiKey')
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
```

### Adding Video Player Package

For real video playback, add `video_player` package:

```yaml
dependencies:
  video_player: ^2.8.0
  chewie: ^1.7.0  # For better controls
```

Then update `VideoPlayerWidget`:

```dart
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerWidget extends StatefulWidget {
  // Use VideoPlayerController and ChewieController
  // for real video playback
}
```

### Theming

Customize colors in `main.dart`:

```dart
theme: ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: const Color(0xFFE50914), // Netflix red
  // Add more theme customization
),
```

## Known Limitations

1. **Mock Data**: Currently uses hardcoded mock data. Replace with real API calls for production.
2. **Video Playback**: Uses a simulated video player. Integrate `video_player` or `better_player` for real playback.
3. **Authentication**: No login system implemented as per requirements.
4. **Search**: Search functionality structure is ready but not fully implemented.
5. **Offline Support**: No local caching implemented.

## Performance Optimization

- Images are loaded with `NetworkImage` (consider adding caching)
- Lists use `ListView.builder` for efficient rendering
- Video player initializes on demand
- Responsive breakpoints optimize for different screen sizes

## Testing

Run tests:
```bash
flutter test
```

Add tests for:
- BLoC events and states
- Use case logic
- Widget rendering
- Repository implementations

## Future Enhancements

- [ ] Search functionality with debouncing
- [ ] User authentication and profiles
- [ ] My List feature with local storage
- [ ] Download for offline viewing
- [ ] Subtitles support
- [ ] Continue watching section
- [ ] Episode selection for TV series
- [ ] Ratings and reviews
- [ ] Multiple audio tracks
- [ ] Watchlist sync across devices

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is for educational purposes only. FlickTv and its content are trademarks of FlickTv, Inc.

## Support

For issues and questions:
- Check Flutter documentation: https://flutter.dev/docs
- BLoC pattern: https://bloclibrary.dev
- Clean Architecture: https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html

---

**Built with ❤️ using Flutter & Clean Architecture**
