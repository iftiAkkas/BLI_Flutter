import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.blue.shade50,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue.shade700,
    elevation: 0,
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.blue.shade100,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.blue.shade900),
    bodyMedium: TextStyle(color: Colors.blue.shade800),
  ),
);
