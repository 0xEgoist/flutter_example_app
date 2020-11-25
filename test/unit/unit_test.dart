import 'package:audio_service/audio_service.dart';
import 'package:flutter_example_app/features/player/audio_service_provider.dart';
import 'package:flutter_example_app/features/track_list/bloc/track_list_bloc.dart';
import 'package:flutter_example_app/repository/models/track.dart';
import 'package:flutter_example_app/repository/tracks_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockTracksRepository extends Mock implements TracksRepository {}

class MockAudioServiceProvider extends Mock implements AudioServiceProvider {}

void main() {
  var tracksRepository;
  var audioPlayerProvider;

  setUp(() {
    tracksRepository = MockTracksRepository();
    audioPlayerProvider = MockAudioServiceProvider();
  });

  test(
    'emits [TrackListLoading, TrackListLoaded] when successful',
    () {
      when(tracksRepository.getNewTracks("lol")).thenAnswer((_) async =>
          TracksResponse(
              tracks: [MediaItem(id: "id", album: "album", title: "title")],
              error: ""));
      final bloc = TrackListBloc(tracksRepository, audioPlayerProvider);
      bloc.add(GetTrackList("lol"));

      expectLater(
        bloc,
        emitsInOrder([
          TrackListLoading(),
          TrackListLoaded(tracksLength: 1, error: ""),
        ]),
      );
    },
  );
}
