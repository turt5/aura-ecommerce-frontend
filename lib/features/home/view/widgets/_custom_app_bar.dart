import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, required this.theme});
  final String title;
  final ColorScheme theme;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: theme.surface,
      title: Text(title,style: GoogleFonts.sora(
        fontSize: 20,
        color: theme.primary,
        fontWeight: FontWeight.bold
      ),),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}