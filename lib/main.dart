import 'package:attira/core/theme/_theme.dart';
import 'package:attira/features/home/view/pages/_homepage.dart';
import 'package:attira/features/splash/view/pages/_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      home: HomePage(),
    );
  }
}
