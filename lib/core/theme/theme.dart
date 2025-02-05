import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plugilo/core/theme/colors.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: GoogleFonts.inter().fontFamily,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.brandPrimary,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: 0,
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: GoogleFonts.inter().fontFamily,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.brandPrimary,
    brightness: Brightness.dark,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: 0,
  ),
);
