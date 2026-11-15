// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/widgets.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

/// Test helper providing an in-memory fake implementation of VideoPlayerPlatform
/// for widget and unit tests running in a headless test environment.
class FakeVideoPlayerPlatform extends VideoPlayerPlatform {
  static void registerWith() {
    VideoPlayerPlatform.instance = FakeVideoPlayerPlatform();
  }

  final Map<int, bool> _isPlaying = {};
  final Map<int, bool> _isLooping = {};
  final Map<int, double> _volume = {};
  int _nextTextureId = 1;

  @override
  Future<void> init() async {}

  @override
  Future<void> dispose(int textureId) async {
    _isPlaying.remove(textureId);
    _isLooping.remove(textureId);
    _volume.remove(textureId);
  }

  @override
  Future<int?> create(DataSource dataSource) async {
    final id = _nextTextureId++;
    _isPlaying[id] = false;
    _isLooping[id] = false;
    _volume[id] = 1.0;
    return id;
  }

  @override
  Future<void> setLooping(int textureId, bool looping) async {
    _isLooping[textureId] = looping;
  }

  @override
  Future<void> play(int textureId) async {
    _isPlaying[textureId] = true;
  }

  @override
  Future<void> pause(int textureId) async {
    _isPlaying[textureId] = false;
  }

  @override
  Future<void> setVolume(int textureId, double volume) async {
    _volume[textureId] = volume;
  }

  @override
  Future<void> setPlaybackSpeed(int textureId, double speed) async {}

  @override
  Future<void> seekTo(int textureId, Duration position) async {}

  @override
  Future<Duration> getPosition(int textureId) async {
    return Duration.zero;
  }

  @override
  Stream<VideoEvent> videoEventsFor(int textureId) {
    return Stream.value(
      VideoEvent(
        eventType: VideoEventType.initialized,
        duration: const Duration(seconds: 10),
        size: const Size(720, 1280),
      ),
    );
  }

  @override
  Widget buildView(int textureId) {
    return const SizedBox();
  }
}
