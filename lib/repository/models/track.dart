import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';

@immutable
class TracksResponse {
  final List<MediaItem> tracks;
  final String error;

  TracksResponse({this.tracks, this.error});

  static TracksResponse fromJson(Map<String, dynamic> json) {
    return TracksResponse(
        tracks: (json["results"] as List)
            .map((i) => getMediaItemFromJson(i))
            .toList(),
        error: "");
  }

  static TracksResponse withError(String errorValue) {
    return TracksResponse(tracks: List(), error: "");
  }
}

MediaItem getMediaItemFromJson(Map<String, dynamic> json) {
  return MediaItem(
      id: json["previewUrl"],
      album: json["collectionName"],
      title: json["trackName"],
      artist: json["artistName"],
      duration: Duration(seconds: 30),
      artUri: json["artworkUrl100"]);
}
