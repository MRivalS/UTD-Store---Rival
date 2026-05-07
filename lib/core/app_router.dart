import 'package:go_router/go_router.dart';
import '../features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import '../features/store/presentation/pages/product_page.dart';
import '../features/store/presentation/pages/cart_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const ProductPage(),
    ),
    GoRoute(path: '/cart', builder: (context, state) => const CartPage()),
  ],
);
