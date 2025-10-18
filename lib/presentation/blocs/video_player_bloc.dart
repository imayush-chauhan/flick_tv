import 'package:flutter_bloc/flutter_bloc.dart';

abstract class VideoPlayerEvent {}

class InitializeVideoEvent extends VideoPlayerEvent {
  final String videoUrl;
  InitializeVideoEvent(this.videoUrl);
}

class PlayVideoEvent extends VideoPlayerEvent {}

class PauseVideoEvent extends VideoPlayerEvent {}

class SeekVideoEvent extends VideoPlayerEvent {
  final Duration position;
  SeekVideoEvent(this.position);
}

class ToggleFullscreenEvent extends VideoPlayerEvent {}

class UpdateVolumeEvent extends VideoPlayerEvent {
  final double volume;
  UpdateVolumeEvent(this.volume);
}

class ToggleMuteEvent extends VideoPlayerEvent {}

abstract class VideoPlayerState {}

class VideoPlayerInitial extends VideoPlayerState {}

class VideoPlayerLoading extends VideoPlayerState {}

class VideoPlayerReady extends VideoPlayerState {
  final String videoUrl;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final bool isFullscreen;
  final double volume;
  final bool isMuted;

  VideoPlayerReady({
    required this.videoUrl,
    required this.isPlaying,
    required this.position,
    required this.duration,
    this.isFullscreen = false,
    this.volume = 1.0,
    this.isMuted = false,
  });

  VideoPlayerReady copyWith({
    String? videoUrl,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    bool? isFullscreen,
    double? volume,
    bool? isMuted,
  }) {
    return VideoPlayerReady(
      videoUrl: videoUrl ?? this.videoUrl,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isFullscreen: isFullscreen ?? this.isFullscreen,
      volume: volume ?? this.volume,
      isMuted: isMuted ?? this.isMuted,
    );
  }
}

class VideoPlayerError extends VideoPlayerState {
  final String message;
  VideoPlayerError(this.message);
}

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  VideoPlayerBloc() : super(VideoPlayerInitial()) {
    on<InitializeVideoEvent>(_onInitialize);
    on<PlayVideoEvent>(_onPlay);
    on<PauseVideoEvent>(_onPause);
    on<SeekVideoEvent>(_onSeek);
    on<ToggleFullscreenEvent>(_onToggleFullscreen);
    on<UpdateVolumeEvent>(_onUpdateVolume);
    on<ToggleMuteEvent>(_onToggleMute);
  }

  Future<void> _onInitialize(
      InitializeVideoEvent event,
      Emitter<VideoPlayerState> emit,
      ) async {
    emit(VideoPlayerLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(VideoPlayerReady(
        videoUrl: event.videoUrl,
        isPlaying: false,
        position: Duration.zero,
        duration: const Duration(minutes: 10),
      ));
    } catch (e) {
      emit(VideoPlayerError(e.toString()));
    }
  }

  void _onPlay(PlayVideoEvent event, Emitter<VideoPlayerState> emit) {
    if (state is VideoPlayerReady) {
      final current = state as VideoPlayerReady;
      emit(current.copyWith(isPlaying: true));
    }
  }

  void _onPause(PauseVideoEvent event, Emitter<VideoPlayerState> emit) {
    if (state is VideoPlayerReady) {
      final current = state as VideoPlayerReady;
      emit(current.copyWith(isPlaying: false));
    }
  }

  void _onSeek(SeekVideoEvent event, Emitter<VideoPlayerState> emit) {
    if (state is VideoPlayerReady) {
      final current = state as VideoPlayerReady;
      emit(current.copyWith(position: event.position));
    }
  }

  void _onToggleFullscreen(
      ToggleFullscreenEvent event,
      Emitter<VideoPlayerState> emit,
      ) {
    if (state is VideoPlayerReady) {
      final current = state as VideoPlayerReady;
      emit(current.copyWith(isFullscreen: !current.isFullscreen));
    }
  }

  void _onUpdateVolume(UpdateVolumeEvent event, Emitter<VideoPlayerState> emit) {
    if (state is VideoPlayerReady) {
      final current = state as VideoPlayerReady;
      emit(current.copyWith(volume: event.volume));
    }
  }

  void _onToggleMute(ToggleMuteEvent event, Emitter<VideoPlayerState> emit) {
    if (state is VideoPlayerReady) {
      final current = state as VideoPlayerReady;
      emit(current.copyWith(isMuted: !current.isMuted));
    }
  }
}