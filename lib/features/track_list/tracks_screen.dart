import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_app/core/app_router.dart';
import 'package:flutter_example_app/features/track_details/details_screen.dart';
import 'package:flutter_example_app/features/track_list/bloc/track_list_bloc.dart';
import 'package:flutter_example_app/features/web_view_etc/map_view.dart';
import 'package:flutter_example_app/features/web_view_etc/video_player.dart';
import 'package:flutter_example_app/features/web_view_etc/web_view.dart';
import 'package:flutter_example_app/generated/i18n.dart';
import 'package:flutter_example_app/repository/models/track.dart';

class TracksScreen extends StatefulWidget {
  @override
  _TracksScreenState createState() => _TracksScreenState();
}

class _TracksScreenState extends State<TracksScreen> {
  TrackListBloc _trackListBloc;

  @override
  Widget build(BuildContext context) {
//<<<<<<< HEAD
//    _trackListBloc = BlocProvider.of<TrackListBloc>(context);
//    return Scaffold(
//      appBar: AppBar(title: Text(I18n.of(context).previewPlayer)),
//      body: WillPopScope(
//        onWillPop: () async {
//          showDialog(
//              context: context,
//              builder: (BuildContext context) {
//                return AlertDialog(
//                  title: Text(I18n.of(context).exit_question),
//                  actions: <Widget>[
//                    FlatButton(
//                      child: Text(I18n.of(context).ok),
//                      onPressed: () {
//                        SystemNavigator.pop();
//                      },
//                    ),
//                    FlatButton(
//                      child: Text(I18n.of(context).no),
//                      onPressed: () {
//                        Navigator.pop(context);
//                      },
//                    )
//                  ],
//                );
//              });
//          return false;
//        },
//        child: BlocBuilder(
//          cubit: _trackListBloc,
//          builder: (context, TrackListState state) {
//            if (state is TrackListLoading) {
//              _trackListBloc.add(GetTrackList());
//              return Center(
//                child: CircularProgressIndicator(
//                  backgroundColor: Colors.blue,
//                ),
//              );
//            }
//            if (state is TrackListLoaded) {
//              return _buildTracksList(state.tracksResponse);
//            }
//            return Center(
//              child: Text(I18n.of(context).something_went_wrong),
//            );
//          },
//=======
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'WebView'),
              Tab(text: 'MapView'),
              Tab(text: 'VideoPlayer'),
            ],
          ),
          title: Text('Sample App'),
        ),
        body: TabBarView(
          children: [
            WebViewScreen(),
            MapViewScreen(),
            VideoPlayerScreen(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _trackListBloc.close();
  }

  Widget _buildTracksList(TracksResponse tracksResponse) {
    final tracksList = tracksResponse.tracks;
    final error = tracksResponse.error;
    if (error.isNotEmpty) {
      return Center(
        child: Text(I18n.of(context).some_error + error),
      );
    }
    if (tracksList.isNotEmpty) {
      return ListView.builder(
        itemCount: tracksList.length,
        itemBuilder: (context, index) => TrackItem(
          tracksList[index],
        ),
      );
    } else {
      return Center(
        child: Text(I18n.of(context).empty_list),
      );
    }
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
