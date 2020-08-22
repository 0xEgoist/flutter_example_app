import 'package:flutter_example_app/repository/api_providers/api.dart';
import 'package:flutter_example_app/repository/models/track.dart';

final tracksRepository = TracksRepository();

class TracksRepository {
  final _tracksProvider = Api();

  Future<TracksResponse> getTracks() {
    return _tracksProvider.getTracks();
  }
}
