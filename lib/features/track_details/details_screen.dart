import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_app/generated/i18n.dart';

class DetailsScreen extends StatelessWidget {
  final DetailsScreenArg arg;

  DetailsScreen(this.arg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(I18n.of(context).trackDetails)),
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
                Navigator.pop(context, I18n.of(context).ok);
              },
              child: Text(I18n.of(context).goBackWithResult),
            )
          ],
        ),
      ),
    );
  }
}

@immutable
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
