import 'package:attira/features/splash/view/widgets/_logo.dart';
import 'package:attira/services/user/firebase/_user_service.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Drawer(
      shape: RoundedRectangleBorder(),
      backgroundColor: theme.surface,
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
                    iconSize: 20,
                    color: theme.onPrimary,
                  ),
                )),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Free Delivery',
                        style: TextStyle(
                            color: theme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    onTap: () {},
                    leading: Icon(
                      Icons.delivery_dining,
                      color: theme.primary,
                    ),
                  ),
                  ListTile(
                    title: Text('New Arrivals',
                        style: TextStyle(
                            color: theme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    onTap: () {},
                    leading: Icon(
                      Icons.new_releases_rounded,
                      color: theme.primary,
                    ),
                  ),
                  ListTile(
                    title: Text('Top Selling',
                        style: TextStyle(
                            color: theme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    onTap: () {},
                    leading: Icon(
                      Icons.star,
                      color: theme.primary,
                    ),
                  ),
                  ListTile(
                    title: Text('Mens',
                        style: TextStyle(
                            color: theme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    onTap: () {},
                    leading: Icon(
                      Icons.man,
                      color: theme.primary,
                    ),
                  ),
                  ListTile(
                    title: Text('Womens',
                        style: TextStyle(
                            color: theme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    onTap: () {},
                    leading: Icon(
                      Icons.woman,
                      color: theme.primary,
                    ),
                  ),
                  ListTile(
                    title: Text('Kids',
                        style: TextStyle(
                            color: theme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    onTap: () {},
                    leading: Icon(
                      Icons.child_friendly,
                      color: theme.primary,
                    ),
                  ),
                  ListTile(
                    title: Text('Accessories',
                        style: TextStyle(
                            color: theme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    onTap: () {},
                    leading: Icon(
                      Icons.miscellaneous_services,
                      color: theme.primary,
                    ),
                  ),
                  ListTile(
                    title: Text('Sports',
                        style: TextStyle(
                            color: theme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    onTap: () {},
                    leading: Icon(
                      Icons.sports,
                      color: theme.primary,
                    ),
                  ),
                  ListTile(
                    title: Text('My Favourites',
                        style: TextStyle(
                            color: theme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    onTap: () {},
                    leading: Icon(
                      Icons.favorite,
                      color: theme.primary,
                    ),
                  ),
                ],
              ),
            )),
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
