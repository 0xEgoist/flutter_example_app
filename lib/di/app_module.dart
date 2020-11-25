import 'package:dio/dio.dart';
import 'package:flutter_example_app/features/player/audio_service_provider.dart';
import 'package:flutter_example_app/repository/api_providers/api.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_example_app/features/track_list/bloc/track_list_bloc.dart';
import 'package:flutter_example_app/repository/tracks_repository.dart';

final inject = GetIt.instance;

void setupDI() {
  inject.registerSingleton<Dio>(Dio());
  inject.registerSingleton<Api>(Api());
  inject.registerSingleton<TracksRepository>(TracksRepository());
  inject.registerSingleton<AudioServiceProvider>(AudioServiceProvider());
  inject.registerFactory<TrackListBloc>(() => TrackListBloc(
      inject<TracksRepository>(), inject<AudioServiceProvider>()));
}
