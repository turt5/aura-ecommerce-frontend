import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getTheme() => ThemeData(
    fontFamily: GoogleFonts.sora().fontFamily,
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: const Color(0xFF1A3636),
        onPrimary: Color(0xFFD6BD98),
        secondary: Color(0xFF40534C),
        onSecondary: Colors.white,
        tertiary: Color(0xFF677D6A),
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.grey.shade200,
        onSurface: Colors.black));
