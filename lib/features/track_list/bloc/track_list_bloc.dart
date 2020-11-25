import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_example_app/features/player/audio_service_provider.dart';
import 'package:flutter_example_app/repository/tracks_repository.dart';

part 'track_list_event.dart';

part 'track_list_state.dart';

class TrackListBloc extends Bloc<TrackListEvent, TrackListState> {
  final TracksRepository _tracksRepository;
  final AudioServiceProvider _audioServiceProvider;

  TrackListBloc(this._tracksRepository, this._audioServiceProvider)
      : super(TrackListLoading());

  @override
  Stream<TrackListState> mapEventToState(
    TrackListEvent event,
  ) async* {
    if (event is GetTrackList) {
      yield TrackListLoading();
      final tracksResponse =
          await _tracksRepository.getNewTracks(event.searchTrackName);
      final tracks = tracksResponse.tracks;
      await _tracksRepository.saveTracksToDB(tracks);
      await _audioServiceProvider.startAudioService(tracks);

      yield TrackListLoaded(
          tracksLength: tracks.length, error: tracksResponse.error);
    }
  }
}
