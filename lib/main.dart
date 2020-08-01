import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_app/router.dart';

main() {
  runApp(MaterialApp(
    initialRoute: Routes.tracksScreen,
    onGenerateRoute: Router.generateRoute,
  ));
}
