import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../splash/view/widgets/_logo.dart';
import '../../controller/_home_model_provider.dart';

class HomeAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppbar(this.scaffoldKey, {super.key, required this.theme});

  final GlobalKey<ScaffoldState> scaffoldKey;
  final ColorScheme theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
        icon: Icon(Icons.menu),
      ),
      toolbarHeight: 70,
      // elevation: 2,
      // shadowColor: theme.primary.withOpacity(0.2),
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
