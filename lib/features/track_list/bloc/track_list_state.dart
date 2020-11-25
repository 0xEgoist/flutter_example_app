part of 'track_list_bloc.dart';

abstract class TrackListState extends Equatable {
  const TrackListState();

  @override
  List<Object> get props => [];
}

class TrackListLoading extends TrackListState {}

class TrackListLoaded extends TrackListState {
  final int tracksLength;
  final String error;

  TrackListLoaded({this.tracksLength, this.error});

  @override
  List<Object> get props => [error];
}
