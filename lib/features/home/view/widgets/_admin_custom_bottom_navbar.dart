import 'package:attira/services/message/firebase/_firestore_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/_admin_home_model.dart';
import '_bottom_nav_items.dart';

class AdminCustomBottomNavigationBar extends StatelessWidget {
  AdminCustomBottomNavigationBar({
    super.key,
    required this.theme,
    required this.homeRead,
    required this.homeWrite,
  });

  final ColorScheme theme;
  final AdminHomeModel homeRead;
  final AdminHomeModel homeWrite;
  final FirestoreService firestoreService = FirestoreService();

  Future<String> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId') ?? '';
  }

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
              child: FutureBuilder<String>(
                  future: _getUserId(), // Fetch userId from shared preferences
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.waiting) {
                      return NavItem(
                        asset: "assets/icon/message.png",
                        activeColor: theme.primary,
                        inactiveColor: Colors.grey.shade600,
                        label: "Inbox",
                        active: homeRead.selected == 3,
                        onPressed: () {
                          homeWrite.selected = 3;
                        },
                        notification: false,
                      );
                    }

                    if (userSnapshot.hasError || !userSnapshot.hasData) {
                      return NavItem(
                        asset: "assets/icon/message.png",
                        activeColor: theme.primary,
                        inactiveColor: Colors.grey.shade600,
                        label: "Inbox",
                        active: homeRead.selected == 3,
                        onPressed: () {
                          homeWrite.selected = 3;
                        },
                        notification: false,
                      );
                    }

                    final userId = userSnapshot.data!;

                    return FutureBuilder(
                      future: Future.wait([
                        firestoreService.countDistinctUsers(userId),
                        firestoreService.countUnreadConversations(userId),
                      ]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return NavItem(
                            asset: "assets/icon/message.png",
                            activeColor: theme.primary,
                            inactiveColor: Colors.grey.shade600,
                            label: "Inbox",
                            active: homeRead.selected == 3,
                            onPressed: () {
                              homeWrite.selected = 3;
                            },
                            // notification: false,
                          );
                        }

                        if (snapshot.hasError || !snapshot.hasData) {
                          return NavItem(
                            asset: "assets/icon/message.png",
                            activeColor: theme.primary,
                            inactiveColor: Colors.grey.shade600,
                            label: "Inbox",
                            active: homeRead.selected == 3,
                            onPressed: () {
                              homeWrite.selected = 3;
                            },
                            // notification: false,
                          );
                        }

                        final counts = snapshot.data as List<int>;
                        final distinctUsersCount = counts[0];
                        final unreadConversationsCount = counts[1];

                        return NavItem(
                          asset: "assets/icon/message.png",
                          activeColor: theme.primary,
                          inactiveColor: Colors.grey.shade600,
                          label: "Inbox",
                          active: homeRead.selected == 3,
                          onPressed: () {
                            homeWrite.selected = 3;
                          },
                          notification: unreadConversationsCount > 0,
                          notificationCount: unreadConversationsCount,
                        );
                      },
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
