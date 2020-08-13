import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example_app/features/track_details/details_screen.dart';
import 'package:flutter_example_app/core/router.dart';
import 'package:flutter_example_app/repository/models/track.dart';
import 'package:flutter_example_app/repository/tracks_repository.dart';

class TracksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview player')),
      body: WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Are you sure you want to exit the application?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                    ),
                    FlatButton(
                      child: Text("NO"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
          return false;
        },
        child: FutureBuilder(
          future: tracksRepository.getTracks(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var trackResponse = snapshot.data as TracksResponse;
              var tracksList = trackResponse.tracks;
              var error = trackResponse.error;
              if (error != "") {
                return Center(
                  child: Text("We have some error: $error"),
                );
              }
              if (tracksList.length != 0) {
                return ListView.builder(
                  itemCount: tracksList.length,
                  itemBuilder: (context, index) => TrackItem(
                    tracksList[index],
                  ),
                );
              } else {
                return Center(
                  child: Text("List of tracks is empty"),
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            );
          },
        ),
      ),
    );
  }
}

class TrackItem extends StatelessWidget {
  final Track _data;

  TrackItem(this._data);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => {
        // navigate to details screen
        _navigateToDetailsAndGetBackResult(context)
      },
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Image.network(
              _data.imageUrl,
              width: 100,
              height: 100,
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
          ),
        ],
      ),
    );
  }

  _navigateToDetailsAndGetBackResult(BuildContext context) async {
    final resultOfBack = await Navigator.pushNamed(
        context, Routes.detailsScreen,
        arguments: DetailsScreenArg(
            artistId: _data.artistId,
            artistName: _data.artistName,
            imageUrl: _data.imageUrl,
            trackId: _data.trackId,
            trackName: _data.trackName));

    if (resultOfBack != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(title: Text(resultOfBack));
          });
    }
  }
}
