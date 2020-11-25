import 'package:audio_service/audio_service.dart';
import 'package:flutter_example_app/features/player/audio_player_task.dart';

class AudioServiceProvider {
  Future<void> startAudioService(List<MediaItem> tracks) async {
    var isServiceStarted = await AudioService.start(
      backgroundTaskEntrypoint: audioPlayerTaskEntrypoint,
      androidNotificationChannelName: 'Audio Service',
      androidStopForegroundOnPause: false,
      androidNotificationColor: 0xFF2196f3,
      androidNotificationIcon: 'mipmap/ic_launcher',
      androidEnableQueue: true,
    );
    if (isServiceStarted) await AudioServiceBackground.setQueue(tracks);
  }
}
