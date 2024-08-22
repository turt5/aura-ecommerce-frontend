import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/_admin_home_model.dart';
import '../../../user-dashboard/view/widgets/_bottom_nav_items.dart';

final userIdProvider = FutureProvider<String>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId') ?? '';
});

final unreadMessagesProvider =
    StreamProvider.autoDispose.family<int, String>((ref, userId) {
  return FirebaseFirestore.instance
      .collection('messages')
      .where('userId', isEqualTo: userId)
      .where('isRead', isEqualTo: false)
      .snapshots()
      .map((snapshot) => snapshot.docs.length);
});

final distinctUsersProvider =
    StreamProvider.autoDispose.family<int, String>((ref, userId) {
  return FirebaseFirestore.instance
      .collection('messages')
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) {
    final users = snapshot.docs.map((doc) => doc['senderId']).toSet();
    return users.length;
  });
});

class AdminCustomBottomNavigationBar extends ConsumerWidget {
  final ColorScheme theme;
  final AdminHomeModel homeRead;
  final AdminHomeModel homeWrite;

  AdminCustomBottomNavigationBar({
    super.key,
    required this.theme,
    required this.homeRead,
    required this.homeWrite,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userIdAsync = ref.watch(userIdProvider);

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          border: Border(
              top:
                  BorderSide(color: theme.primary.withOpacity(.05), width: 2))),
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
              child: userIdAsync.when(
                data: (userId) {
                  final unreadCountAsync =
                      ref.watch(unreadMessagesProvider(userId));
                  final distinctUsersCountAsync =
                      ref.watch(distinctUsersProvider(userId));

                  return unreadCountAsync.when(
                    data: (unreadCount) {
                      return distinctUsersCountAsync.when(
                        data: (distinctUsersCount) {
                          return NavItem(
                            asset: "assets/icon/message.png",
                            activeColor: theme.primary,
                            inactiveColor: Colors.grey.shade600,
                            label: "Inbox",
                            active: homeRead.selected == 3,
                            onPressed: () {
                              homeWrite.selected = 3;
                            },
                            notification: unreadCount > 0,
                            notificationCount: unreadCount,
                          );
                        },
                        loading: () => _buildLoadingNavItem(),
                        error: (_, __) => _buildErrorNavItem(),
                      );
                    },
                    loading: () => _buildLoadingNavItem(),
                    error: (_, __) => _buildErrorNavItem(),
                  );
                },
                loading: () => _buildLoadingNavItem(),
                error: (_, __) => _buildErrorNavItem(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  NavItem _buildLoadingNavItem() {
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

  NavItem _buildErrorNavItem() {
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
}
