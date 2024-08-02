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
      padding: const EdgeInsets.symmetric(horizontal: 50),
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
                label: "Categories",
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
            ),

          ],
        ),
      ),
    );
  }
}
