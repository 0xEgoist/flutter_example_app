part of 'track_list_bloc.dart';

abstract class TrackListEvent extends Equatable {
  const TrackListEvent();

  @override
  List get props => [];
}

class GetTrackList extends TrackListEvent {}
