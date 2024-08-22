import 'package:flutter/material.dart';
import '../../../../services/message/firebase/_firestore_message.dart';
import '../../model/_home_model_riverpod.dart';
import '_bottom_nav_items.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({
    super.key,
    required this.theme,
    required this.homeRead,
    required this.homeWrite,
  });

  final FirestoreService firestoreService = FirestoreService();
  final ColorScheme theme;
  final HomeModelRiverpod homeRead;
  final HomeModelRiverpod homeWrite;

  Future<Map<String, dynamic>> _getUserData() async {
    return await homeRead.getUserData();
  }

  Future<List<int>> _getCounts(String userId) async {
    return await Future.wait([
      firestoreService.countDistinctUsers(userId),
      firestoreService.countUnreadConversations(userId),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: theme.surface,
        border: Border(
          top: BorderSide(
            color: theme.primary.withOpacity(.05),
            width: 2,
          ),
        ),
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
                notification: false,
              ),
            ),
            FutureBuilder<Map<String, dynamic>>(
              future: _getUserData(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: NavItem(
                      asset: "assets/icon/message.png",
                      activeColor: theme.primary,
                      inactiveColor: Colors.grey.shade600,
                      label: "Inbox",
                      active: homeRead.selected == 3,
                      onPressed: () {
                        homeWrite.selected = 3;
                      },
                      notification: false,
                    ),
                  );
                }

                if (userSnapshot.hasError || !userSnapshot.hasData) {
                  return Expanded(
                    child: NavItem(
                      asset: "assets/icon/message.png",
                      activeColor: theme.primary,
                      inactiveColor: Colors.grey.shade600,
                      label: "Inbox",
                      active: homeRead.selected == 3,
                      onPressed: () {
                        homeWrite.selected = 3;
                      },
                      notification: false,
                    ),
                  );
                }

                final userId = userSnapshot.data!['userId'] as String;

                return FutureBuilder<List<int>>(
                  future: _getCounts(userId),
                  builder: (context, countSnapshot) {
                    if (countSnapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                        child: NavItem(
                          asset: "assets/icon/message.png",
                          activeColor: theme.primary,
                          inactiveColor: Colors.grey.shade600,
                          label: "Inbox",
                          active: homeRead.selected == 3,
                          onPressed: () {
                            homeWrite.selected = 3;
                          },
                          notification: false,
                        ),
                      );
                    }

                    if (countSnapshot.hasError || !countSnapshot.hasData) {
                      return Expanded(
                        child: NavItem(
                          asset: "assets/icon/message.png",
                          activeColor: theme.primary,
                          inactiveColor: Colors.grey.shade600,
                          label: "Inbox",
                          active: homeRead.selected == 3,
                          onPressed: () {
                            homeWrite.selected = 3;
                          },
                          notification: false,
                        ),
                      );
                    }

                    final counts = countSnapshot.data!;
                    final distinctUsersCount = counts[0];
                    final unreadConversationsCount = counts[1];

                    return Expanded(
                      child: NavItem(
                        asset: "assets/icon/message.png",
                        activeColor: theme.primary,
                        inactiveColor: Colors.grey.shade600,
                        label: "Inbox",
                        active: homeRead.selected == 3,
                        onPressed: () {
                          homeWrite.selected = 3;
                        },
                        notification: unreadConversationsCount > 0,
                      ),
                    );
                  },
                );
              },
            ),
            Expanded(
              child: NavItem(
              asset: "assets/icon/user-icon.png",
              label: "Profile",
              activeColor: theme.primary,
              inactiveColor: Colors.grey.shade600,
              active: homeRead.selected == 4,
              scale: 1.8,
              onPressed: () {
                homeWrite.selected = 4;
              },
              notification: false,
            ),
            ),
          ],
        ),
      ),
    );
  }
}
