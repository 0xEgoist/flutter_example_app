import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_app/core/router.dart';

import 'package:dio/dio.dart';

import 'core/network_utils.dart';

main() {
  dio.interceptors.add(LogInterceptor());
  dio.options.receiveTimeout = 15000;
  runApp(MaterialApp(
    initialRoute: Routes.tracksScreen,
    onGenerateRoute: Router.generateRoute,
  ));
}
