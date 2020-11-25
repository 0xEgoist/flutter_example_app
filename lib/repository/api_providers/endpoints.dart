const itunes = "https://itunes.apple.com/";

String getTracksUrl(String trackName) => itunes + "search?term=$trackName&entity=musicTrack";
