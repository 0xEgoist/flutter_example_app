import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_app/generated/i18n.dart';
import 'package:rxdart/rxdart.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).trackDetails),
      ),
      body: Center(
        child: StreamBuilder(
            stream: AudioService.currentMediaItemStream,
            builder: (context, snapshot) {
              if (AudioService.queue.isEmpty) {
                Navigator.pop(context);
                return Center();
              }
              final MediaItem item = snapshot.data ?? AudioService.queue.first;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    item.artUri,
                    width: 200,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                  SizedBox.fromSize(
                    size: Size(0, 20),
                  ),
                  Text(
                    item.title,
                    // widget.arg.trackName,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    item.artist,
                  ),
                  SizedBox.fromSize(
                    size: Size(0, 20),
                  ),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                      onPressed: AudioService.skipToPrevious,
                      iconSize: 64.0,
                      icon: Icon(Icons.skip_previous),
                      color: Colors.cyan,
                    ),
                    StreamBuilder(
                      stream: AudioService.playbackStateStream,
                      builder: (context, snapshot) {
                        final state = snapshot.data;
                        final playing = state?.playing ?? false;
                        return IconButton(
                          onPressed: () {
                            if (playing)
                              AudioService.pause();
                            else
                              AudioService.play();
                          },
                          iconSize: 64.0,
                          icon: playing
                              ? Icon(Icons.pause)
                              : Icon(Icons.play_arrow),
                          color: Colors.cyan,
                        );
                      },
                    ),
                    IconButton(
                      onPressed: AudioService.skipToNext,
                      iconSize: 64.0,
                      icon: Icon(Icons.skip_next),
                      color: Colors.cyan,
                    ),
                  ]),
                  positionIndicator(item)
                ],
              );
            }),
      ),
    );
  }

  Widget positionIndicator(MediaItem mediaItem) {
    return StreamBuilder(
      stream: Rx.combineLatest2<PlaybackState, double, PlaybackState>(
          AudioService.playbackStateStream,
          Stream.periodic(Duration(milliseconds: 200)),
          (state, _) => state),
      builder: (context, snapshot) {
        final PlaybackState state = snapshot.data;
        double duration = mediaItem?.duration?.inMilliseconds?.toDouble() ?? 0;
        return Column(
          children: [
            if (duration != null)
              Slider(
                min: 0.0,
                max: duration,
                value: max(
                    0.0,
                    min(state?.currentPosition?.inMilliseconds?.toDouble() ?? 0,
                        duration)),
                onChanged: (value) {},
                onChangeEnd: (value) {
                  AudioService.seekTo(Duration(milliseconds: value.toInt()));
                },
              ),
            Text(
                "${state?.currentPosition?.inMinutes ?? 0} : ${state?.currentPosition?.inSeconds ?? 0}"),
          ],
        );
      },
    );
  }
}
