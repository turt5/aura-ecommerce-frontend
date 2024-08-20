import 'package:attira/features/home/controller/_home_model_provider.dart';
import 'package:attira/features/home/view/pages/admin_manage_users_profile.dart';
import 'package:attira/features/home/view/widgets/_custom_app_bar.dart';
import 'package:attira/services/user/firebase/_user_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminManageUsersPage extends ConsumerStatefulWidget {
  const AdminManageUsersPage({super.key});

  @override
  _AdminManageUsersPageState createState() => _AdminManageUsersPageState();
}

class _AdminManageUsersPageState extends ConsumerState<AdminManageUsersPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_updateSearchQuery);
  }

  @override
  void dispose() {
    _searchController.removeListener(_updateSearchQuery);
    _searchController.dispose();
    super.dispose();
  }

  void _updateSearchQuery() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    FirebaseService firebaseService = FirebaseService();
    final homeRead = ref.watch(homeModelProvider);

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: CustomAppBar(title: "Manage Users", theme: theme),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.onSurface.withOpacity(.2),
                width: 2
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10,),
            child: Row(
              children: [
                Icon(Icons.search,color: theme.onSurface.withOpacity(.3),),
                const SizedBox(width: 7,),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search User',
                      hintStyle: TextStyle(
                        color: theme.onSurface.withOpacity(.3)
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
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
                    // Filter users based on the search query
                    List<Users> filteredUsers = usersList.where((user) {
                      return user.name!.toLowerCase().contains(_searchQuery);
                    }).toList();

                    return Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: Center(
                            child: Text('Current Users: ${filteredUsers.length}'),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: filteredUsers.length,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemBuilder: (context, index) {
                              Users user = filteredUsers[index];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                    color: user.activeStatus!
                                        ? theme.primary.withOpacity(.1)
                                        : theme.error.withOpacity(.5)),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical:10, horizontal: 15),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                AdminManageUsersProfile(
                                                    name: user.name,
                                                    userId: user.userId,
                                                    email: user.email,
                                                    role: user.role,
                                                    imageUrl: user.imageUrl,
                                                    phone: user.phone)));
                                  },
                                  leading: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                        imageUrl: user.imageUrl,
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder: (context, a, b) {
                                          return CupertinoActivityIndicator(
                                            radius: 10,
                                            color: theme.primary,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  title: FutureBuilder(
                                      future: homeRead.getUserData(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CupertinoActivityIndicator(
                                            radius: 10,
                                            color: theme.primary,
                                          );
                                        } else if (snapshot.hasData) {
                                          return Text(
                                              "${user.name} ${snapshot.data!['userId'] == user.userId ? "(You)" : ""}");
                                        } else {
                                          return Text("Something went wrong");
                                        }
                                      }),
                                  trailing: FutureBuilder(
                                      future: homeRead.getUserData(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CupertinoActivityIndicator(
                                            radius: 10,
                                            color: theme.primary,
                                          );
                                        } else if (snapshot.hasData) {
                                          bool isCurrentUser = snapshot.data!['userId'] == user.userId;
                                          return isCurrentUser ? SizedBox.shrink() : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                  onPressed: user.activeStatus!
                                                      ? () {
                                                    firebaseService.disableUser(
                                                        user.userId);
                                                  }
                                                      : () {},
                                                  icon: Icon(
                                                    Icons.dnd_forwardslash,
                                                    color: user.activeStatus!
                                                        ? theme.error
                                                        : theme.onSurface
                                                        .withOpacity(.3),
                                                  )),
                                              IconButton(
                                                  onPressed: !user.activeStatus!
                                                      ? () {
                                                    firebaseService.enableUser(
                                                        user.userId);
                                                  }
                                                      : null,
                                                  icon: Icon(
                                                    Icons.add_circle_outline,
                                                    color: !user.activeStatus!
                                                        ? Colors.green
                                                        : theme.onSurface
                                                        .withOpacity(.3),
                                                  )),
                                            ],
                                          );
                                        } else {
                                          return Text("Something went wrong");
                                        }
                                      }),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    print(snapshot.error);
                    return const Center(
                      child: Text('Something went wrong!'),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
