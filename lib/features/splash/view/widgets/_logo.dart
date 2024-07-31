import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AttiraLogo extends StatelessWidget {
  const AttiraLogo(
      {super.key,
      required this.theme,
      required this.fontSize,
      required this.iconSize,
      this.alignment,
      this.color});

  final ColorScheme theme;
  final double fontSize;
  final double iconSize;
  final bool? alignment;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment == null
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Text('AURA.',
            style: GoogleFonts.righteous(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: color ?? theme.primary,
            )),
      ],
    );
  }
}
