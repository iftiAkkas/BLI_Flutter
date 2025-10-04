import 'package:flutter/material.dart';

final lightTheme = (String font) => ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      fontFamily: font,
    );

final darkTheme = (String font) => ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      fontFamily: font,
    );
