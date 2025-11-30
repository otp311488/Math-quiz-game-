import 'package:audioplayers/audioplayers.dart';

class BackgroundMusic {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static bool _isPlaying = false;

  static Future<void> playMusic() async {
    if (!_isPlaying) {
      // Set the release mode to loop
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      // Play the audio
      await _audioPlayer.play(AssetSource('mixkit-fun-and-games-6.mp3'), volume: 0.5);
      _isPlaying = true;
    }
  }

  static Future<void> stopMusic() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      _isPlaying = false;
    }
  }
}
