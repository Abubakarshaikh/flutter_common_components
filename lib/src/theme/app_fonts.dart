import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Font family names for fonts bundled by the host app.
abstract final class AppFonts {
  static const String sourceSansPro = 'SourceSansPro';
  static const String openSans = 'OpenSans';
  static const String montserrat = 'Montserrat';
  static const String pacifico = 'Pacifico';
  static const String notoNastaliqUrdu = 'NotoNastaliqUrdu';
  static const String amiri = 'Amiri';
  static const String baloo = 'Baloo';
}

/// Ready-made [TextTheme]s backed by `google_fonts`.
abstract final class AppTextThemes {
  static TextTheme get openSans => GoogleFonts.openSansTextTheme();
  static TextTheme get pacifico => GoogleFonts.pacificoTextTheme();
  static TextTheme get lato => GoogleFonts.latoTextTheme();
  static TextTheme get poppins => GoogleFonts.poppinsTextTheme();
  static TextTheme get roboto => GoogleFonts.robotoTextTheme();
}
