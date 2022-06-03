import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:medfind_flutter/Presentation/splash_screen.dart';

import '../Screens/Admin/admin_screen.dart';

class MedfindRouter {
  // ignore: unused_fiel
  static final GoRouter router = GoRouter(
    initialLocation: "/admin",
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: '/Home',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: '/search',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
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
      GoRoute(
        path: "/admin",
        builder: (BuildContext context, GoRouterState state) =>
            const AdminScreen(),
      )
    ],
  );
}
