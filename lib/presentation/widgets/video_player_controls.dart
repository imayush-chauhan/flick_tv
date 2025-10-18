import 'package:flick_tv/presentation/blocs/video_player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoPlayerControls extends StatelessWidget {
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final double volume;
  final bool isMuted;
  final bool isFullscreen;

  const VideoPlayerControls({
    Key? key,
    required this.isPlaying,
    required this.position,
    required this.duration,
    required this.volume,
    required this.isMuted,
    required this.isFullscreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.3),
            Colors.transparent,
            Colors.transparent,
            Colors.black.withOpacity(0.7),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
                if (!isMobile)
                  IconButton(
                    icon: Icon(
                      isMuted ? Icons.volume_off : Icons.volume_up,
                      size: 28,
                    ),
                    onPressed: () {
                      context.read<VideoPlayerBloc>().add(ToggleMuteEvent());
                    },
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      _formatDuration(position),
                      style: const TextStyle(fontSize: 12),
                    ),
                    Expanded(
                      child: Slider(
                        value: position.inMilliseconds.toDouble(),
                        max: duration.inMilliseconds.toDouble(),
                        activeColor: const Color(0xFFE50914),
                        inactiveColor: Colors.grey[600],
                        onChanged: (value) {
                          context.read<VideoPlayerBloc>().add(
                            SeekVideoEvent(Duration(milliseconds: value.toInt())),
                          );
                        },
                      ),
                    ),
                    Text(
                      _formatDuration(duration),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.replay_10, size: 32),
                      onPressed: () {
                        final newPos = position - const Duration(seconds: 10);
                        context.read<VideoPlayerBloc>().add(
                          SeekVideoEvent(newPos < Duration.zero ? Duration.zero : newPos),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                        size: 56,
                      ),
                      onPressed: () {
                        if (isPlaying) {
                          context.read<VideoPlayerBloc>().add(PauseVideoEvent());
                        } else {
                          context.read<VideoPlayerBloc>().add(PlayVideoEvent());
                        }
                      },
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(Icons.forward_10, size: 32),
                      onPressed: () {
                        final newPos = position + const Duration(seconds: 10);
                        context.read<VideoPlayerBloc>().add(
                          SeekVideoEvent(newPos > duration ? duration : newPos),
                        );
                      },
                    ),
                    const Spacer(),
                    if (!isMobile)
                      IconButton(
                        icon: Icon(
                          isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                          size: 28,
                        ),
                        onPressed: () {
                          context.read<VideoPlayerBloc>().add(ToggleFullscreenEvent());
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours > 0) {
      return "$hours:$minutes:$seconds";
    }
    return "$minutes:$seconds";
  }
}