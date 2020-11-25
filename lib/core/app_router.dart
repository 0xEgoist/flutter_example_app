import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_example_app/features/search_tracks/search_screen.dart';
import 'package:flutter_example_app/features/track_details/details_screen.dart';
import 'package:flutter_example_app/features/track_list/tracks_screen.dart';

class Routes {
  static const searchScreen = '/';
  static const tracksScreen = '/tracks';
  static const detailsScreen = '/details';
}

class AppRouter {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.searchScreen:
        return MaterialPageRoute(
            builder: (_) => AudioServiceWidget(child: SearchScreen()));
      case Routes.tracksScreen:
        final arg = settings.arguments as SearchScreenArg;
        return MaterialPageRoute(
            builder: (_) =>
                AudioServiceWidget(child: TracksScreen(arg)));
      case Routes.detailsScreen:
        return MaterialPageRoute(builder: (_) => DetailsScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
