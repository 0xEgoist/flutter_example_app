import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_app/tracks_data.dart';

main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Preview player')),
      body: TracksList(trackData),
    ),
  ));
}

class TracksList extends StatelessWidget {
  final List<TrackData> tracksList;

  TracksList(this.tracksList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tracksList.length,
      itemBuilder: (context, index) => TrackItem(
        tracksList[index],
      ),
    );
  }
}

class TrackItem extends StatelessWidget {
  final TrackData _data;

  TrackItem(this._data);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Image.network(
            _data.logoUrl,
            width: 100,
            height: 100,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    _data.trackName,
                    style: TextStyle(fontSize: 20),
                  )),
              Text(
                _data.artistName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              )
            ],
          ),
        ),
      ],
    );
  }
}
