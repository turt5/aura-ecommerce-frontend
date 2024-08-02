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
            Expanded(
                child: ListView(
              children: [
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.manage_accounts,
                    color: theme.primary,
                  ),
                  title: Text(
                    'Manage Users',
                    style: TextStyle(color: theme.primary),
                  ),
                ),ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.settings,
                    color: theme.primary,
                  ),
                  title: Text(
                    'Manage Products',
                    style: TextStyle(color: theme.primary),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.category,
                    color: theme.primary,
                  ),
                  title: Text(
                    'Manage Categories',
                    style: TextStyle(color: theme.primary),
                  ),
                ),

                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.discount,
                    color: theme.primary,
                  ),
                  title: Text(
                    'Add Discounts',
                    style: TextStyle(color: theme.primary),
                  ),
                ),
              ],
            )),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ElevatedButton(
                onPressed: () async {
                  FirebaseService firebaseService = FirebaseService();

                  firebaseService.logoutUser();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MyApp()));
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
