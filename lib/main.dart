import 'package:attira/core/theme/_theme.dart';
import 'package:attira/features/user-dashboard/view/pages/_homepage.dart';
import 'package:attira/features/splash/view/pages/_splash.dart';
import 'package:attira/services/message/provider/_firestore_message_provider.dart';
import 'package:attira/services/notification/firebase/_firebase_cloud_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/admin-dashboard/view/widgets/_admin_home_bridge.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseNotification().initNotifications();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getLightTheme(),
      darkTheme: getDarkTheme(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, prefsSnapshot) {
          if (prefsSnapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for SharedPreferences
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: SafeArea(
                child: Center(
                  child: CupertinoActivityIndicator(
                    radius: 11,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            );
          } else if (prefsSnapshot.hasData) {
            SharedPreferences prefs = prefsSnapshot.data!;

            bool isLoggedIn =
                prefs.containsKey('userId') && prefs.containsKey('role');

            if (isLoggedIn) {
              String role = prefs.getString('role') ?? '';

              return StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, authSnapshot) {
                  if (authSnapshot.connectionState == ConnectionState.waiting) {
                    return Scaffold(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      body: SafeArea(
                        child: Center(
                          child: CupertinoActivityIndicator(
                            radius: 11,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    );
                  } else if (authSnapshot.hasData) {
                    // User is authenticated
                    if (role == 'admin') {
                      return AdminHomePage();
                    } else if (role == 'user') {
                      return HomePage();
                    } else {
                      return SplashScreen();
                    }
                  } else {
                    return SplashScreen();
                  }
                },
              );
            } else {
              // User is not logged in, show the splash screen
              return SplashScreen();
            }
          } else {
            // Handle error state
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: const Center(
                child: Text('An error occurred!'),
              ),
            );
          }
        },
      ),
    );
  }
}
