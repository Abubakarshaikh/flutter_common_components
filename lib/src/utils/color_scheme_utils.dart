import 'package:flutter/material.dart';

final class _ColorsUtils {
  
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

abstract class ColorSchemeUtils {
  static const ColorScheme kDarkColorScheme = ColorScheme(
    primary: _ColorsUtils.white,
    onPrimary: _ColorsUtils.black,
    secondary: _ColorsUtils.jetBlack,
    onSecondary: _ColorsUtils.white,
    surface: _ColorsUtils.black,
    onSurface: _ColorsUtils.white,
    error: _ColorsUtils.red,
    onError: _ColorsUtils.white,
    outline: _ColorsUtils.sonicSilver,
    brightness: Brightness.dark,
  );

  static const ColorScheme kCharcoalColorScheme = ColorScheme(
    primary: _ColorsUtils.white,
    onPrimary: _ColorsUtils.black,
    secondary: _ColorsUtils.darkBluishGray,
    onSecondary: _ColorsUtils.white,
    surface: _ColorsUtils.charcoal,
    onSurface: _ColorsUtils.white,
    outline: _ColorsUtils.cadetBlue,
    brightness: Brightness.dark,
    error: _ColorsUtils.red,
    onError: _ColorsUtils.white,
  );

  static const ColorScheme kStandardColorScheme = ColorScheme(
    primary: _ColorsUtils.cherryRed,
    onPrimary: _ColorsUtils.white,
    secondary: _ColorsUtils.azaleaPink,
    onSecondary: _ColorsUtils.black,
    surface: _ColorsUtils.white,
    onSurface: _ColorsUtils.black,
    error: _ColorsUtils.red,
    onError: _ColorsUtils.white,
    outline: _ColorsUtils.lightGrey,
    brightness: Brightness.light,
  );
}
