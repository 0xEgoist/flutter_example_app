import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final DetailsScreenArg arg;

  DetailsScreen(this.arg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Track Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              arg.imageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
            SizedBox.fromSize(
              size: Size(0, 20),
            ),
            Text(
              arg.trackName,
              style: TextStyle(fontSize: 20),
            ),
            Text(arg.artistName),
            SizedBox.fromSize(
              size: Size(0, 20),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context, "OK");
              },
              child: Text("Go back with result - OK"),
            )
          ],
        ),
      ),
    );
  }
}

class DetailsScreenArg {
  final int artistId;
  final String artistName;
  final String imageUrl;
  final int trackId;
  final String trackName;

  DetailsScreenArg(
      {this.artistId,
      this.artistName,
      this.imageUrl,
      this.trackId,
      this.trackName});
}
