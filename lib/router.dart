import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_example_app/details_screen.dart';
import 'package:flutter_example_app/tracks_data.dart';
import 'package:flutter_example_app/tracks_screen.dart';

class Routes {
  static const tracksScreen = '/';
  static const detailsScreen = '/details';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.tracksScreen:
        return MaterialPageRoute(builder: (_) => TracksScreen(trackData));
      case Routes.detailsScreen:
        var arg = settings.arguments as DetailsScreenArg;
        return MaterialPageRoute(builder: (_) => DetailsScreen(arg));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
