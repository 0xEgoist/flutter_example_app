import 'package:audio_service/audio_service.dart';
import 'package:flutter_example_app/di/app_module.dart';
import 'package:flutter_example_app/repository/api_providers/api.dart';
import 'package:flutter_example_app/repository/local/database.dart';
import 'package:flutter_example_app/repository/models/track.dart';

class TracksRepository {
  final Api _tracksProvider = inject<Api>();

  TracksRepository();

  Future<TracksResponse> getNewTracks(String trackName) {
    return _tracksProvider.getTracks(trackName);
  }

  Future<void> saveTracksToDB(List<MediaItem> tracks) async {
    await deleteTracksFromDB();
    await insertTracksToDB(tracks);
  }
}
