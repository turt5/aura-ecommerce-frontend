import 'package:attira/features/admin-dashboard/controller/_admin_home_provider.dart';
import 'package:attira/features/admin-dashboard/view/pages/_admin_add_product.dart';
import 'package:attira/features/admin-dashboard/view/pages/_admin_orders.dart';
import 'package:attira/features/user-dashboard/controller/_user_home_model_provider.dart';
import 'package:attira/features/admin-dashboard/view/widgets/_admin_custom_bottom_navbar.dart';
import 'package:attira/features/admin-dashboard/view/pages/_admin_home_body.dart';
import 'package:attira/features/admin-dashboard/view/pages/_admin_inbox.dart';
import 'package:attira/features/splash/view/widgets/_logo.dart';
import 'package:attira/main.dart';
import 'package:attira/services/user/firebase/_user_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '_admin_appbar.dart';
import '_admin_home_drawer.dart';

class AdminHomePage extends ConsumerWidget {
  AdminHomePage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final read = ref.watch(homeModelProvider);
    final write = ref.read(homeModelProvider);
    final adminHomeRead = ref.watch(adminHomeProvider);
    final adminHomeWrite = ref.read(adminHomeProvider);

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: theme.surface,
        appBar: AdminAppBar(
          theme: theme,
          scaffoldKey: _scaffoldKey,
          read: read,
          write: write,
        ),
        drawer: AdminHomeDrawer(
          theme: theme,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 30,
                width: double.infinity,
                color: theme.primary,
                child: Center(
                  child: Text(
                    'Administrator Account',
                    style: TextStyle(color: theme.onPrimary),
                  ),
                ),
              ),
              Expanded(
                  child: adminHomeRead.selected == 0
                      ? AdminHomeBody(
                    theme: theme,
                  )
                      : adminHomeRead.selected == 1
                          ? AdminAddProduct()
                          : adminHomeRead.selected == 2? AdminOrders() : AdminInbox()),
              AdminCustomBottomNavigationBar(
                  theme: theme,
                  homeRead: adminHomeRead,
                  homeWrite: adminHomeWrite)
            ],
          ),
        ));
  }
}
