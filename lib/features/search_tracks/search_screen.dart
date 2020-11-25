import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_example_app/core/app_router.dart';
import 'package:flutter_example_app/generated/i18n.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(I18n.of(context).search_tracks),
        ),
        body: WillPopScope(
          onWillPop: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(I18n.of(context).exit_question),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(I18n.of(context).ok),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                      ),
                      FlatButton(
                        child: Text(I18n.of(context).no),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                });
            return false;
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: textController,
                    decoration: InputDecoration(labelText: 'Enter track name'),
                  ),
                  SizedBox.fromSize(
                    size: Size(0, 20),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.tracksScreen,
                          arguments:
                              SearchScreenArg(trackName: textController.text));
                    },
                    child: const Text('Search', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

@immutable
class SearchScreenArg {
  final String trackName;

  SearchScreenArg({this.trackName});
}
