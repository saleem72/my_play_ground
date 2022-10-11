//

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        // fontFamily: _fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w300,
        color: Colors.black,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      foregroundColor: Colors.blueAccent,
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        // fontFamily: _fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
      // foregroundColor: Colors.blueAccent,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
  );
}
