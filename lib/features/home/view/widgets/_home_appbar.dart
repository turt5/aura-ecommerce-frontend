import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../splash/view/widgets/_logo.dart';
import '../../controller/_home_model_provider.dart';

class HomeAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key, required this.theme, required this.user});

  final ColorScheme theme;
  final dynamic user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final read = ref.watch(homeModelProvider);
    final write = ref.read(homeModelProvider);
    return AppBar(
      toolbarHeight: 70,
      elevation: 2,
      shadowColor: theme.primary.withOpacity(0.2),
      title: AttiraLogo(
        fontSize: 18,
        iconSize: 20,
        theme: theme,
        alignment: true,
      ),
      centerTitle: false,
      actions: [
        SizedBox(
          width: 50,
          child: Text(
            user['name'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.sora(
              color: theme.primary,
              fontSize: 13,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        const SizedBox(width: 5),
        Container(
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
                return InkWell(
                  onTap: (){},
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(.4),
                        border: Border.all(
                        color: theme.primary,
                        width: 2
                    )
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
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
        ),
        const SizedBox(width: 20,)
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
