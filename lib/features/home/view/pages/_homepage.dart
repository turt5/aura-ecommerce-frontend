import 'package:attira/features/home/controller/_home_model_provider.dart';
import 'package:attira/features/splash/view/widgets/_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/_bottom_nav_items.dart';

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
        elevation: 1,
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
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const CircleAvatar(
              radius: 12,
            ),
          )
        ],
      ),
      drawer: const Drawer(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Container(
              color: theme.primary,
            )),
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: NavItem(
                        asset: "assets/icon/home.png",
                        activeColor: theme.primary,
                        inactiveColor: Colors.grey.shade600,
                        label: "Home",
                        active: homeRead.selected == 0,
                        onPressed: () {
                          homeWrite.selected = 0;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: NavItem(
                        asset: "assets/icon/menu.png",
                        activeColor: theme.primary,
                        inactiveColor: Colors.grey.shade600,
                        label: "Categories",
                        active: homeRead.selected == 1,
                        onPressed: () {
                          homeWrite.selected = 1;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: NavItem(
                        asset: "assets/icon/cart.png",
                        activeColor: theme.primary,
                        inactiveColor: Colors.grey.shade600,
                        label: "Cart",
                        active: homeRead.selected == 2,
                        onPressed: () {
                          homeWrite.selected = 2;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
