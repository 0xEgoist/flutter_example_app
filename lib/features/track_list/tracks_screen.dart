import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example_app/core/app_router.dart';
import 'package:flutter_example_app/di/app_module.dart';
import 'package:flutter_example_app/features/search_tracks/search_screen.dart';
import 'package:flutter_example_app/features/track_list/bloc/track_list_bloc.dart';
import 'package:flutter_example_app/features/track_list/track_item.dart';
import 'package:flutter_example_app/generated/i18n.dart';
import 'package:rxdart/rxdart.dart';

class TracksScreen extends StatefulWidget {
  final SearchScreenArg _arg;

  TracksScreen(this._arg);

  @override
  _TracksScreenState createState() => _TracksScreenState();
}

final _needToRefreshListStream = PublishSubject<bool>();

class _TracksScreenState extends State<TracksScreen> {
  final TrackListBloc _trackListBloc = inject<TrackListBloc>();
  var serviceWasInterrupted = false;

  int _selectedTrackId = -1;

  @override
  Widget build(BuildContext context) {
    _trackListBloc.add(GetTrackList(widget._arg.trackName));
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).previewPlayer),
        actions: [
          StreamBuilder(
            stream: AudioService.currentMediaItemStream,
            builder: (context, snapshot) {
              return Visibility(
                visible: _selectedTrackId != -1,
                child: Padding(
                  child: InkWell(
                    child: Center(
                      child: GestureDetector(
                        child: Text(I18n.of(context).current_track),
                        onTap: () {
                          Navigator.pushNamed(context, Routes.detailsScreen);
                        },
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(right: 20),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder(
        cubit: _trackListBloc,
        builder: (context, TrackListState state) {
          if (state is TrackListLoading) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            );
          }
          if (state is TrackListLoaded) {
            return _buildTracksList(state.tracksLength, state.error);
          }
          return Center(
            child: Text(I18n.of(context).something_went_wrong),
          );
        },
      ),
    );
  }

  Widget _buildTracksList(int repoTracksLength, String error) {
    if (error.isNotEmpty) {
      return Center(
        child: Text(I18n.of(context).some_error + error),
      );
    }
    // if (tracksList.isNotEmpty) {
    return StreamBuilder<ScreenState>(
        stream: _screenStateStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final screenState = snapshot.data;
            final queue = screenState?.queue;
            final mediaItem = screenState?.mediaItem;

            if (_selectedTrackId != -1)
              _selectedTrackId = mediaItem?.id?.hashCode ?? -1;
            final state = screenState?.playbackState;
            final playing = state?.playing ?? false;

            if (queue != null && queue.isNotEmpty) {
              serviceWasInterrupted = true;
              return StreamBuilder<bool>(
                  stream: _needToRefreshListStream.stream,
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: queue.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            _selectedTrackId = queue[index]?.id?.hashCode ?? -1;
                            final currentMediaItemId =
                                AudioService.currentMediaItem?.id?.hashCode ??
                                    -1;
                            if (currentMediaItemId != _selectedTrackId) {
                              AudioService.skipToQueueItem(queue[index].id);
                              AudioService.play();
                              _needToRefreshListStream.add(true);
                              return;
                            }

                            if (playing)
                              AudioService.pause();
                            else
                              AudioService.play();
                            _needToRefreshListStream.add(true);
                          },
                          child: TrackItem(
                            queue[index],
                            _selectedTrackId == queue[index].id.hashCode,
                          ),
                        );
                      },
                    );
                  });
            } else {
              if (repoTracksLength > 0) {
                if (serviceWasInterrupted) {
                  serviceWasInterrupted = false;
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    setState(() {});
                  });
                }
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ));
              }
              return Center(
                child: Text(I18n.of(context).empty_list),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            );
          }
        });
  }

  @override
  void dispose() {
    _trackListBloc.close();
    super.dispose();
  }
}

class ScreenState {
  final List<MediaItem> queue;
  final MediaItem mediaItem;

  final PlaybackState playbackState;

  ScreenState(this.queue, this.mediaItem, this.playbackState);
}

Stream<ScreenState> get _screenStateStream =>
    Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState, ScreenState>(
        AudioService.queueStream,
        AudioService.currentMediaItemStream,
        AudioService.playbackStateStream,
        (queue, item, state) => ScreenState(queue, item, state));
