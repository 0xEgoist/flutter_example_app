import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example_app/details_screen.dart';
import 'package:flutter_example_app/router.dart';
import 'package:flutter_example_app/tracks_data.dart';

class TracksScreen extends StatelessWidget {
  final List<TrackData> tracksList;

  TracksScreen(this.tracksList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview player')),
      body: ListView.builder(
        itemCount: tracksList.length,
        itemBuilder: (context, index) => TrackItem(
          tracksList[index],
        ),
      ),
    );
  }
}

class TrackItem extends StatelessWidget {
  final TrackData _data;

  TrackItem(this._data);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
      child: GestureDetector(
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
        ),
      ),
    );
  }

  _navigateToDetailsAndGetBackResult(BuildContext context) async {
    final resultOfBack = await Navigator.pushNamed(
        context, Routes.detailsScreen,
        arguments: DetailsScreenArg(_data.trackName));

    if (resultOfBack != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(title: Text(resultOfBack));
          });
    }
  }
}
