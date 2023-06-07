import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/app/themes/app_colors.dart';

class AppThemes {
  AppThemes._();

  static final ThemeData themData = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColors.kPrimaryColor,
    // primarySwatch: AppColors.kPrimaryColor,
    // primaryColor: AppColors.kPrimaryColor,
    // visualDensity: VisualDensity.adaptivePlatformDensity,
    // textTheme: GoogleFonts.sourceSansProTextTheme(),
  );
}
