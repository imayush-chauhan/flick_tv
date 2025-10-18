import 'package:flick_tv/presentation/blocs/video_player_bloc.dart';
import 'package:flick_tv/presentation/widgets/video_player_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final bool autoPlay;

  const VideoPlayerWidget({
    Key? key,
    required this.videoUrl,
    this.autoPlay = true,
  }) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  bool _showControls = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoPlayerBloc()
        ..add(InitializeVideoEvent(widget.videoUrl)),
      child: BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
        builder: (context, state) {
          if (state is VideoPlayerLoading) {
            return Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(color: Color(0xFFE50914)),
              ),
            );
          }

          if (state is VideoPlayerError) {
            return Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(state.message),
                  ],
                ),
              ),
            );
          }

          if (state is VideoPlayerReady) {
            if (widget.autoPlay && !state.isPlaying) {
              Future.microtask(() {
                context.read<VideoPlayerBloc>().add(PlayVideoEvent());
              });
            }

            return GestureDetector(
              onTap: () {
                setState(() => _showControls = !_showControls);
              },
              child: Stack(
                children: [
                  Container(
                    color: Colors.black,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey[900]!,
                                Colors.grey[800]!,
                              ],
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  state.isPlaying ? Icons.play_circle_filled : Icons.pause_circle_filled,
                                  size: 80,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Video Player',
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  state.isPlaying ? 'Playing...' : 'Paused',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_showControls)
                    VideoPlayerControls(
                      isPlaying: state.isPlaying,
                      position: state.position,
                      duration: state.duration,
                      volume: state.volume,
                      isMuted: state.isMuted,
                      isFullscreen: state.isFullscreen,
                    ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}