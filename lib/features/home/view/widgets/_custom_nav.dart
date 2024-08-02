import 'package:attira/features/home/view/widgets/_nav_profile_item.dart';
import 'package:flutter/material.dart';

import '../../model/_home_model_riverpod.dart';
import '_bottom_nav_items.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.theme,
    required this.homeRead,
    required this.homeWrite,
  });

  final ColorScheme theme;
  final HomeModelRiverpod homeRead;
  final HomeModelRiverpod homeWrite;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,

      decoration: BoxDecoration(
        color: theme.surface,
        border: Border(
          top: BorderSide(
            color: theme.primary.withOpacity(.05),
            width: 2
          )
        )
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: NavItem(
                asset: "assets/icon/home_rounded.png",
                activeColor: theme.primary,
                inactiveColor: Colors.grey.shade600,
                label: "Home",
                active: homeRead.selected == 0,
                onPressed: () {
                  homeWrite.selected = 0;
                },
              ),
            ),

            Expanded(
              child: NavItem(
                iconData: Icons.category_outlined,
                asset: "assets/icon/menu.png",
                activeColor: theme.primary,
                inactiveColor: Colors.grey.shade600,
                label: "Category",
                active: homeRead.selected == 1,
                onPressed: () {
                  homeWrite.selected = 1;
                },
              ),
            ),

            Expanded(
              child: NavItem(
                asset: "assets/icon/bag.png",
                activeColor: theme.primary,
                inactiveColor: Colors.grey.shade600,
                label: "Cart",
                active: homeRead.selected == 2,
                onPressed: () {
                  homeWrite.selected = 2;
                },
                notification: true,
              ),
            ),Expanded(
              child: NavItem(
                asset: "assets/icon/message.png",
                activeColor: theme.primary,
                inactiveColor: Colors.grey.shade600,
                label: "Inbox",
                active: homeRead.selected == 3,
                onPressed: () {
                  homeWrite.selected = 3;
                },
                notification: true,
              ),
            ),

            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: homeRead.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while waiting for data
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    // Handle any errors
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    // Handle the case where there is no data
                    return NavItem(
                      asset: "assets/icon/bag.png",
                      activeColor: theme.primary,
                      inactiveColor: Colors.grey.shade600,
                      label: "Cart",
                      active: homeRead.selected == 4,
                      iconData: Icons.person_outlined,
                      onPressed: () {
                        homeWrite.selected = 4;
                      },
                      notification: true,
                    );
                  }

                  final user = snapshot.data!; // Safe to use `!` now

                  return NavProfileItem(
                    url: user['imageUrl'],
                    label: "Profile",
                    activeColor: theme.primary,
                    inactiveColor: Colors.grey.shade600,
                    active: homeRead.selected == 4,
                    onPressed: () {
                      homeWrite.selected = 4;
                    },
                  );
                },
              ),
            )


          ],
        ),
      ),
    );
  }
}
