import 'package:attira/features/user-dashboard/controller/_user_home_model_provider.dart';
import 'package:attira/features/user-dashboard/view/pages/_cart_body.dart';
import 'package:attira/features/user-dashboard/view/pages/_categories_body.dart';
import 'package:attira/features/user-dashboard/view/widgets/_drawer.dart';
import 'package:attira/features/user-dashboard/view/widgets/_home_appbar.dart';
import 'package:attira/features/user-dashboard/view/pages/_home_body.dart';
import 'package:attira/features/user-dashboard/view/pages/_home_profile.dart';
import 'package:attira/features/user-dashboard/view/widgets/_user_home_bridge.dart';
import 'package:attira/features/user-dashboard/view/pages/_user_inbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/_custom_nav.dart';

class HomePage extends ConsumerWidget {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final homeRead = ref.watch(homeModelProvider);
    final homeWrite = ref.read(homeModelProvider);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: theme.brightness,
        statusBarColor: theme.surface,
        systemNavigationBarColor: theme.surface,
        systemNavigationBarIconBrightness: theme.brightness));

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                child: UserHomeBridge(
              read: homeRead,
            )),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
            theme: theme, homeRead: homeRead, homeWrite: homeWrite),
      ),
    );
  }
}
