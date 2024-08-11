import 'package:attira/features/home/controller/_home_model_provider.dart';
import 'package:attira/features/home/view/widgets/_cart_body.dart';
import 'package:attira/features/home/view/widgets/_categories_body.dart';
import 'package:attira/features/home/view/widgets/_drawer.dart';
import 'package:attira/features/home/view/widgets/_home_appbar.dart';
import 'package:attira/features/home/view/widgets/_home_body.dart';
import 'package:attira/features/home/view/widgets/_home_profile.dart';
import 'package:attira/features/home/view/widgets/_user_home_bridge.dart';
import 'package:attira/features/home/view/widgets/_user_inbox.dart';
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

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: UserHomeBridge(read: homeRead,)),
          CustomBottomNavigationBar(
              theme: theme, homeRead: homeRead, homeWrite: homeWrite)
        ],
      )),
    );
  }
}
