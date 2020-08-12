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
            Text(arg.title),
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
  final String title;

  DetailsScreenArg(this.title);
}
