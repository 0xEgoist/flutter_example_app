import 'dart:async';
import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const _dbName = 'tracks_database.db';
const _tracksTableName = 'tracks';
const _version = 1;

Future<void> insertTracksToDB(List<MediaItem> tracks) async {
  final Database db = await _getDatabase();
  await db.insert(
    _tracksTableName,
    {"trackList": jsonEncode(tracks)},
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<MediaItem>> getTracksFromDB() async {
  final Database db = await _getDatabase();
  final List<Map<String, dynamic>> tracks = await db.query(_tracksTableName);
  return (jsonDecode(tracks.first["trackList"]) as List)
      .map((e) => MediaItem(
          id: e['id'],
          artist: e['artist'],
          album: e['album'],
          artUri: e['artUri'],
          title: e['title'],
          duration: Duration(milliseconds: e['duration'])))
      .toList();
}

Future<void> deleteTracksFromDB() async {
  // Get a reference to the database.
  final db = await _getDatabase();
  await db.execute('DELETE FROM $_tracksTableName');
}

Future<Database> _getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), _dbName),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE $_tracksTableName (trackList TEXT)",
      );
    },
    version: _version,
  );
}
