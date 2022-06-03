import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Presentation/Screens/MedicineSearch/home.dart';
import 'package:medfind_flutter/Presentation/Screens/MedicineSearch/search_result.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/bottom_navigation_bar.dart';

import 'package:medfind_flutter/Presentation/splash_screen.dart';

class MedfindRouter {
  // ignore: unused_field
  static final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) => const Home(),
      ),
      GoRoute(
        path: '/search',
        builder: (BuildContext context, GoRouterState state) =>
            const SearchResult(),
      ),
      GoRoute(
        path: '/watch_list',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: '/reservation',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
    ],
  );
}
