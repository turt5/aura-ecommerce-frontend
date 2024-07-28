import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AttiraLogo extends StatelessWidget {
  const AttiraLogo(
      {super.key,
      required this.theme,
      required this.fontSize,
      required this.iconSize});

  final ColorScheme theme;
  final double fontSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: iconSize,
          height: iconSize,
          child: SvgPicture.asset(
            'assets/svg/attira-logo.svg',
            color: theme.primary,
          ),
        ),
        const SizedBox(width: 10),
        Text('Attira',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: theme.primary,
            )),
      ],
    );
  }
}
