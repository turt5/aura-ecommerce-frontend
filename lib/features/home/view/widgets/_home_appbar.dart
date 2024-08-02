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
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
