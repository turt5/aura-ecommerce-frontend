import 'package:attira/features/splash/view/widgets/_logo.dart';
import 'package:flutter/material.dart';

class AdminHomeDrawer extends StatelessWidget {
  const AdminHomeDrawer({super.key, required this.theme});
  final ColorScheme theme;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: theme.surface,
      shape: RoundedRectangleBorder(),
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              
                decoration: BoxDecoration(
                  color: theme.primary,
                ),
                child: Center(
              child: AttiraLogo(theme: theme, fontSize: 20, iconSize: 15,color: theme.onPrimary,),
            ))
          ],
        ),
      ),
    );
  }
}
