part of 'track_list_bloc.dart';

abstract class TrackListEvent extends Equatable {
  final String searchTrackName;

  const TrackListEvent(this.searchTrackName);

  @override
  List get props => [searchTrackName];
}

class GetTrackList extends TrackListEvent {
  GetTrackList(String searchTrackName) : super(searchTrackName);
}
