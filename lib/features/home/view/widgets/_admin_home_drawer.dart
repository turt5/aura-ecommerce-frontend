import 'package:attira/features/splash/view/widgets/_logo.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../../services/user/firebase/_user_service.dart';

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
                  child: AttiraLogo(
                    theme: theme,
                    fontSize: 20,
                    iconSize: 15,
                    color: theme.onPrimary,
                  ),
                )),
            Expanded(child: Center(child: Text('Drawer Items'),)),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ElevatedButton(
                onPressed: () async {
                  FirebaseService firebaseService = FirebaseService();

                  firebaseService.logoutUser();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MyApp()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.error,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(color: theme.onError),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
