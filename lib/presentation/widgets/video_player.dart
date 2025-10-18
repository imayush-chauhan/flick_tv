import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayersWidget extends StatefulWidget {
  final String videoUrl;
  final bool autoPlay;
  const VideoPlayersWidget({
    super.key,
    required this.videoUrl,
    this.autoPlay = true,
  });

  @override
  State<VideoPlayersWidget> createState() => _VideoPlayersWidgetState();
}

class _VideoPlayersWidgetState extends State<VideoPlayersWidget> {
  static final List<VideoPlayerController> _activeControllers = [];

  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    for (var controller in _activeControllers) {
      if (controller.value.isPlaying) controller.pause();
    }
    _activeControllers.clear();

    _videoController = VideoPlayerController.network(widget.videoUrl);
    await _videoController!.initialize();

    _activeControllers.add(_videoController!);

    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: widget.autoPlay,
      looping: false,
      allowFullScreen: true,
      allowMuting: true,
    );

    setState(() {
      _initialized = true;
    });
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    _activeControllers.remove(_videoController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      floatingActionButton:
      IconButton(
        color: Colors.white,
          onPressed: (){
        Navigator.of(context).pop();
      }, icon: const Icon(Icons.arrow_back_ios_new)),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: SafeArea(child: Chewie(controller: _chewieController!)));
  }
}
