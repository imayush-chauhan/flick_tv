import 'package:flick_tv/domain/entities/movie.dart';
import 'package:flick_tv/presentation/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';

class FullScreenVideoPlayer extends StatelessWidget {
  final Movie movie;

  const FullScreenVideoPlayer({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: VideoPlayerWidget(
        videoUrl: movie.videoUrl,
        autoPlay: true,
      ),
    );
  }
}