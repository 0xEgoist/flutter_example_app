import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class TrackItem extends StatelessWidget {
  final MediaItem _data;
  final bool _isCurrentTrackPlayed;

  TrackItem(
    this._data,
    this._isCurrentTrackPlayed,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.network(
                _data.artUri,
                width: 100,
                height: 100,
              ),
              Visibility(
                visible: _isCurrentTrackPlayed,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 2,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    child: StreamBuilder<Object>(
                        stream: AudioService.playbackStateStream,
                        builder: (context, snapshot) {
                          final PlaybackState state = snapshot?.data;
                          final playing = state?.playing ?? false;
                          return Icon(
                            playing ? Icons.pause : Icons.play_arrow,
                            color: Colors.black,
                          );
                        }),
                    backgroundColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      _data.title,
                      style: TextStyle(fontSize: 20),
                    )),
                Text(
                  _data.artist,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
