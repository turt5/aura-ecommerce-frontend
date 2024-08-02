import 'package:attira/features/home/controller/_home_model_provider.dart';
import 'package:attira/features/home/model/_home_model_riverpod.dart';
import 'package:attira/features/home/view/widgets/_cart_body.dart';
import 'package:attira/features/home/view/widgets/_categories_body.dart';
import 'package:attira/features/home/view/widgets/_drawer.dart';
import 'package:attira/features/home/view/widgets/_home_appbar.dart';
import 'package:attira/features/home/view/widgets/_home_body.dart';
import 'package:attira/features/home/view/widgets/_home_profile.dart';
import 'package:attira/features/home/view/widgets/_user_inbox.dart';
import 'package:attira/features/splash/view/widgets/_logo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/_bottom_nav_items.dart';
import '../widgets/_custom_nav.dart';

class HomePage extends ConsumerWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final homeRead = ref.watch(homeModelProvider);
    final homeWrite = ref.read(homeModelProvider);

    return FutureBuilder<Map<String, dynamic>>(
      future: homeRead.getUserData(),
      builder: (context,snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CupertinoActivityIndicator(
            radius: 12,
            color: theme.primary,
          ),);
        }else if(snapshot.hasError){
          return Center(child: Text('Something went wrong'));
        }else if(snapshot.hasData){

          final user = snapshot.data!;

          return Scaffold(
            key: _scaffoldKey, // Set the key here
            backgroundColor: theme.surface,
            appBar: HomeAppbar(theme: theme, user: user),
            drawer: const AppDrawer(),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                      child: homeRead.selected == 0
                          ? const HomeBody()
                          : homeRead.selected == 1
                          ? const CategoriesBody()
                          : homeRead.selected == 2? const CartBody(): homeRead.selected == 3? UserInbox() : HomeProfilePage()),
                  CustomBottomNavigationBar(
                      theme: theme, homeRead: homeRead, homeWrite: homeWrite)
                ],
              ),
            ),
          );
        }else{
          return const Center(child: Text('Something went wrong!'));
        }
      }
    );
  }
}
