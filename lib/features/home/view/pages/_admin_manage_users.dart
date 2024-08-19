import 'package:attira/features/home/view/pages/admin_manage_users_profile.dart';
import 'package:attira/features/home/view/widgets/_custom_app_bar.dart';
import 'package:attira/services/user/firebase/_user_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminManageUsersPage extends StatelessWidget {
  const AdminManageUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    FirebaseService firebaseService = FirebaseService();

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: CustomAppBar(title: "Manage Users", theme: theme),
      body: StreamBuilder(
          stream: firebaseService.getAllUsersData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CupertinoActivityIndicator(
                radius: 12,
                color: theme.primary,
              ));
            } else if (snapshot.hasData && !snapshot.hasError) {
              List<Users> usersList = snapshot.data!;
              return Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Center(
                      child: Text('Current Users: ${usersList.length}'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: usersList.length,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemBuilder: (context, index) {
                        Users user = usersList[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: theme.primary.withOpacity(.1)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          AdminManageUsersProfile(
                                            name:user.name,
                                            userId: user.userId,
                                            email:user.email,
                                            role:user.role,
                                            imageUrl:user.imageUrl,
                                            phone:user.phone
                                          )));
                            },
                            leading: SizedBox(
                              height: 40,
                              width: 40,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CachedNetworkImage(
                                  imageUrl: user.imageUrl,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder: (context,a,b){
                                    return CupertinoActivityIndicator(
                                      radius: 10,
                                      color: theme.primary,
                                    );
                                  },
                                ),
                              ),
                            ),
                            title: Text(user.name),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Something went wrong!'),
              );
            }
          }),
    );
  }
}
