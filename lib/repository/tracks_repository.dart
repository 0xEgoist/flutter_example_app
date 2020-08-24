import 'package:flutter_example_app/repository/api_providers/tracks_provider.dart';
import 'package:flutter_example_app/repository/models/track.dart';

final tracksRepository = TracksRepository();

class TracksRepository {
  final _tracksProvider = TracksProvider();

  Future<TracksResponse> getTracks() {
    return _tracksProvider.getTracks();
  }
}
