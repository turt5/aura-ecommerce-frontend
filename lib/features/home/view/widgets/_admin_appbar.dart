import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../splash/view/widgets/_logo.dart';

class AdminAppBar extends StatelessWidget implements PreferredSizeWidget{
  const AdminAppBar({super.key, required this.theme, required this.scaffoldKey, this.read, this.write});

  final ColorScheme theme;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final dynamic read;
  final dynamic write;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: theme.onPrimary,
      leading: IconButton(
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
        icon: Icon(
          Icons.menu,
          color: theme.primary,
        ),
      ),
      title: Row(
        children: [
          AttiraLogo(
            theme: theme,
            fontSize: 20,
            iconSize: 15,
            color: theme.primary,
            alignment: true,
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: FutureBuilder<Map<String, dynamic>>(
            future: read.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(.5),
                  ),
                  child: const Center(
                    child: CupertinoActivityIndicator(
                      radius: 10,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(.5),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.error,
                      color: theme.onError,
                      size: 15,
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                final user = snapshot.data!;
                return Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(.4),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: user['imageUrl'],
                      progressIndicatorBuilder: (context, _, progress) {
                        return const Center(
                          child: CupertinoActivityIndicator(
                            radius: 10,
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(.5),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.error,
                      color: theme.onError,
                      size: 15,
                    ),
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
