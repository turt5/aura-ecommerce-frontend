import 'package:attira/features/home/controller/_home_model_provider.dart';
import 'package:attira/features/home/model/_home_model_riverpod.dart';
import 'package:attira/features/home/view/widgets/_drawer.dart';
import 'package:attira/features/home/view/widgets/_home_body.dart';
import 'package:attira/features/splash/view/widgets/_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/_bottom_nav_items.dart';
import '../widgets/_custom_nav.dart';

class HomePage extends ConsumerWidget {
  // Create a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final homeRead = ref.watch(homeModelProvider);
    final homeWrite = ref.read(homeModelProvider);

    return Scaffold(
      key: _scaffoldKey, // Set the key here
      backgroundColor: theme.surface,
      appBar: AppBar(
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
              "John Doe",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: theme.primary,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const CircleAvatar(
            radius: 12,
          ),
          const SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () {},
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Stack(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  margin: const EdgeInsets.only(right: 20),
                  child: Image.asset(
                    'assets/icon/cart.png',
                    color: theme.secondary,
                  ),
                ),
                Positioned(
                    right: 18,
                    top: 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    ))
              ],
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: HomeBody()),
            CustomBottomNavigationBar(
                theme: theme, homeRead: homeRead, homeWrite: homeWrite)
          ],
        ),
      ),
    );
  }
}
