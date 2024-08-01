import 'package:attira/core/theme/_theme.dart';
import 'package:attira/features/home/view/pages/_homepage.dart';
import 'package:attira/features/splash/view/pages/_splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/home/view/pages/_admin_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTheme(),
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

            // Check if 'userId' and 'role' keys are present
            bool isLoggedIn = prefs.containsKey('userId') && prefs.containsKey('role') ;

            if (isLoggedIn) {
              // User is logged in, check the role and navigate accordingly
              String role = prefs.getString('role') ?? '';

              return StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, authSnapshot) {
                  if (authSnapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while waiting for auth state
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
                      return AdminHomePage(); // Replace with your admin page
                    } else if (role == 'user') {
                      return HomePage(); // Replace with your user page
                    } else {
                      return SplashScreen();
                    }
                  } else {
                    // Auth state is not available
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
              body: Center(
                child: Text('An error occurred!'),
              ),
            );
          }
        },
      ),
    );
  }
}
