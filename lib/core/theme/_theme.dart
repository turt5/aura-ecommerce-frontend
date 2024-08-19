import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getLightTheme() => ThemeData(
    fontFamily: GoogleFonts.sora().fontFamily,
    colorScheme: ColorScheme.light(
        brightness: Brightness.dark,
        primary: const Color(0xFF1A3636),
        onPrimary: const Color(0xFFD6BD98),
        secondary: const Color(0xFF40534C),
        onSecondary: Colors.white,
        tertiary: const Color(0xFF677D6A),
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.grey.shade200,
        onSurface: Colors.black));


ThemeData getDarkTheme() => ThemeData(
    fontFamily: GoogleFonts.sora().fontFamily,
    colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: CupertinoColors.activeBlue,
        onPrimary: Colors.white,
        secondary: Color(0xFF40534C),
        onSecondary: Colors.white,
        tertiary: Color(0xFF677D6A),
        error: Colors.red,
        onError: Colors.white,
        surface: Color(0xFF161110),
        onSurface: Colors.white));