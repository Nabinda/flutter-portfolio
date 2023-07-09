import 'package:flutter/material.dart';

const fontFamily = 'Poppins';

final themeLight = ThemeData(
  primaryColorLight: const Color(0xff3bb2d0),
  brightness: Brightness.light,
  primaryColor: const Color(0xff3bb2d0),
  highlightColor: Colors.black,
  canvasColor: Colors.white,
  fontFamily: fontFamily,
  backgroundColor: Colors.white,
  splashColor: Colors.transparent,
  hoverColor: const Color(0xff3bb2d0).withOpacity(0.5),
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
    secondary: Colors.black,
    brightness: Brightness.light,
  ),
);

final themeDark = ThemeData(
  brightness: Brightness.dark,
  primaryColorDark: const Color(0xff3bb2d0),
  primaryColor: const Color(0xff3bb2d0),
  highlightColor: const Color(0xff3bb2d0),
  canvasColor: Colors.white,
  fontFamily: fontFamily,
  splashColor: Colors.transparent,
  backgroundColor: Colors.grey[800],
  scaffoldBackgroundColor: Colors.black,
  hoverColor: const Color(0xff3bb2d0),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
    secondary: const Color(0xffC0392B),
    brightness: Brightness.dark,
  ),
);
