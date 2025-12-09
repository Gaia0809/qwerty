import 'package:flutter/material.dart';
import 'package:better_color_changer/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router, 
      title: 'Better Color Changer',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
    );
  }
}