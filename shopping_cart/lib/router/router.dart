import 'package:flutter/material.dart'; 
import 'package:go_router/go_router.dart';
import 'package:shopping_cart/pages/product.dart';
import 'package:shopping_cart/pages/cart.dart';

final GoRouter router = GoRouter(
  initialLocation: '/product',
  routes: <RouteBase>[
    GoRoute(
      path: '/product',
      builder: (BuildContext context, GoRouterState state) {
        return const ProductListScreen();
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (BuildContext context, GoRouterState state) {
        return const CartScreen();
      },
    ),
  ],
);