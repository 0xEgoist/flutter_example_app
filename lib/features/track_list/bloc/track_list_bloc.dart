import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_example_app/repository/models/track.dart';
import 'package:flutter_example_app/repository/tracks_repository.dart';

part 'track_list_event.dart';
part 'track_list_state.dart';

class TrackListBloc extends Bloc<TrackListEvent, TrackListState> {
  TrackListBloc() : super(TrackListLoading());

  @override
  Stream<TrackListState> mapEventToState(
    TrackListEvent event,
  ) async* {
    if (event is GetTrackList) {

      final tracks = await tracksRepository.getTracks();
      yield TrackListLoaded(tracks);
    }
  }
}
