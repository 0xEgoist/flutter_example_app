import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example_app/core/app_router.dart';
import 'package:flutter_example_app/features/track_list/bloc/track_list_bloc.dart';
import 'package:flutter_example_app/generated/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/network_utils.dart';

main() {
  dio.interceptors.add(LogInterceptor());
  dio.options.receiveTimeout = 15000;
  final i18n = I18n.delegate;
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TrackListBloc>(
        create: (ctx) => TrackListBloc(),
      )
    ],
    child: MaterialApp(
      localizationsDelegates: [
        i18n,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: i18n.supportedLocales,
      localeResolutionCallback: i18n.resolution(),
      initialRoute: Routes.tracksScreen,
      onGenerateRoute: AppRouter.generateRoute,
    ),
  ));
}
