import 'package:attira/core/theme/_theme.dart';
import 'package:attira/features/login/view/pages/_login.dart';
import 'package:attira/features/register/view/pages/_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/splash/view/pages/_splash.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTheme(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
