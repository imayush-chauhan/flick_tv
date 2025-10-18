import 'package:flick_tv/domain/entities/movie.dart';
import 'package:flick_tv/presentation/routes/route_names.dart';
import 'package:flick_tv/presentation/screens/home_screen.dart';
import 'package:flick_tv/presentation/screens/movie_details_screen.dart';
import 'package:flick_tv/presentation/widgets/video_player.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      name: RouteNames.home,
      path: RouteNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: RouteNames.detail,
      path: RouteNames.detail,
      builder: (context, state) {
        Movie movie = state.extra as Movie;
        return MovieDetailsScreen(movie: movie);
      },
    ),
    GoRoute(
      name: RouteNames.video,
      path: RouteNames.video,
      builder: (context, state) {
        Map data = state.extra as Map;
        return VideoPlayersWidget(videoUrl: data["videoUrl"], autoPlay: data["autoPlay"],);
      },
    ),
  ],
  initialLocation: RouteNames.home,
);
