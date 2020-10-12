import 'package:flutter/material.dart';
import 'package:hkk/pages/main_menu.dart';
import 'package:hkk/pages/single_play.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => SinglePlay(),
      '/home': (context) => MainMenu(),
      '/singlePlay': (context) => SinglePlay(),
    },
  ));
}
