import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_app/core/app_router.dart';
import 'package:flutter_example_app/di/app_module.dart';
import 'package:flutter_example_app/generated/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  final Dio _dio = inject<Dio>();

  @override
  Widget build(BuildContext context) {
    _dio.interceptors.add(LogInterceptor());
    _dio.options.receiveTimeout = 15000;
    final i18n = I18n.delegate;

    return MaterialApp(
      localizationsDelegates: [
        i18n,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: i18n.supportedLocales,
      localeResolutionCallback: i18n.resolution(),
      initialRoute: Routes.searchScreen,
      onGenerateRoute: (settings) {
        return AppRouter.generateRoute(settings);
      },
    );
  }
}
