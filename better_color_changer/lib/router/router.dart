import 'package:flutter/material.dart'; 
import 'package:go_router/go_router.dart';
import 'package:better_color_changer/pages/home.dart';
import 'package:better_color_changer/pages/settings.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: <RouteBase>[
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsPage();
      },
    ),
  ],
);
