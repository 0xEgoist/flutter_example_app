import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_example_app/features/track_details/details_screen.dart';
import 'package:flutter_example_app/features/track_list/tracks_screen.dart';
import 'package:flutter_example_app/features/web_view_etc/map_view.dart';
import 'package:flutter_example_app/features/web_view_etc/video_player.dart';
import 'package:flutter_example_app/features/web_view_etc/web_view.dart';

class Routes {
  static const tracksScreen = '/';
  static const detailsScreen = '/details';

  static const webView = '/webView';
  static const mapView = '/mapView';
  static const videoPlayer = '/videoPlayer';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.tracksScreen:
        return MaterialPageRoute(builder: (_) => TracksScreen());
      case Routes.detailsScreen:
        var arg = settings.arguments as DetailsScreenArg;
        return MaterialPageRoute(builder: (_) => DetailsScreen(arg));

      case Routes.webView:
        return MaterialPageRoute(builder: (_) => WebViewScreen());
      case Routes.mapView:
        return MaterialPageRoute(builder: (_) => MapViewScreen());
      case Routes.videoPlayer:
        return MaterialPageRoute(builder: (_) => VideoPlayerScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
