import 'package:flutter/material.dart';

abstract final class _Palette {
  static const Color cherryRed = Color(0xffCC313D);
  static const Color red = Color(0xFFF44336);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color jetBlack = Color(0xff343434);
  static const Color charcoal = Color(0xff36454F);
  static const Color lightGrey = Color(0xfff2f2f2);
  static const Color darkBluishGray = Color(0xff212B31);
  static const Color sonicSilver = Color(0xff757575);
  static const Color cadetBlue = Color(0xff90A4AE);
  static const Color azaleaPink = Color(0xffF7C5CC);
}

abstract final class AppColorSchemes {
  static const ColorScheme standard = ColorScheme(
    brightness: Brightness.light,
    primary: _Palette.cherryRed,
    onPrimary: _Palette.white,
    secondary: _Palette.azaleaPink,
    onSecondary: _Palette.black,
    surface: _Palette.white,
    onSurface: _Palette.black,
    error: _Palette.red,
    onError: _Palette.white,
    outline: _Palette.lightGrey,
  );

  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: _Palette.white,
    onPrimary: _Palette.black,
    secondary: _Palette.jetBlack,
    onSecondary: _Palette.white,
    surface: _Palette.black,
    onSurface: _Palette.white,
    error: _Palette.red,
    onError: _Palette.white,
    outline: _Palette.sonicSilver,
  );

  static const ColorScheme charcoal = ColorScheme(
    brightness: Brightness.dark,
    primary: _Palette.white,
    onPrimary: _Palette.black,
    secondary: _Palette.darkBluishGray,
    onSecondary: _Palette.white,
    surface: _Palette.charcoal,
    onSurface: _Palette.white,
    error: _Palette.red,
    onError: _Palette.white,
    outline: _Palette.cadetBlue,
  );
}
