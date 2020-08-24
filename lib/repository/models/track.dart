class TracksResponse {
  final List<Track> tracks;
  final String error;

  TracksResponse(this.tracks, this.error);

  TracksResponse.fromJson(Map<String, dynamic> json)
      : tracks = (json["results"] as List)
            .map((i) => new Track.fromJson(i))
            .toList(),
        error = "";

  TracksResponse.withError(String errorValue)
      : tracks = List(),
        error = errorValue;
}

class Track {
  final int artistId;
  final String artistName;
  final String imageUrl;
  final int trackId;
  final String trackName;

  Track(
    this.artistId,
    this.artistName,
    this.imageUrl,
    this.trackId,
    this.trackName,
  );

  Track.fromJson(Map<String, dynamic> json)
      : artistId = json["artistId"],
        artistName = json["artistName"],
        imageUrl = json["artworkUrl100"],
        trackId = json["trackId"],
        trackName = json["trackName"];
}
