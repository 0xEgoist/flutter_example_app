import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_app/app.dart';
import 'package:flutter_example_app/di/app_module.dart';

void main() async {
  setupDI();
  runApp(App());
}
