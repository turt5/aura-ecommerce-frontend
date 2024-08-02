import 'package:flutter/material.dart';

import '../../model/_admin_home_model.dart';
import '_bottom_nav_items.dart';

class AdminCustomBottomNavigationBar extends StatelessWidget {
  const AdminCustomBottomNavigationBar({
    super.key,
    required this.theme,
    required this.homeRead,
    required this.homeWrite,
  });

  final ColorScheme theme;
  final AdminHomeModel homeRead;
  final AdminHomeModel homeWrite;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.primary.withOpacity(.05),
            width: 2
          )
        )
      ),
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
            // const SizedBox(
            //   width: 15,
            // ),
            Expanded(
              child: NavItem(
                asset: "assets/icon/add.png",
                activeColor: theme.primary,
                inactiveColor: Colors.grey.shade600,
                label: "Add Items",
                active: homeRead.selected == 1,
                onPressed: () {
                  homeWrite.selected = 1;
                },
              ),
            ),
            // const SizedBox(
            //   width: 15,
            // ),

            Expanded(
              child: NavItem(
                asset: "assets/icon/parcel.png",
                activeColor: theme.primary,
                inactiveColor: Colors.grey.shade600,
                label: "Orders",
                active: homeRead.selected == 2,
                onPressed: () {
                  homeWrite.selected = 2;
                },
              ),
            ),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
