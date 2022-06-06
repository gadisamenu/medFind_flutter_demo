import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Domain/Admin/APharamcy.dart';
import 'package:medfind_flutter/Domain/Admin/User.dart';
import 'package:medfind_flutter/Presentation/Screens/Admin/pharmacy_detail_update.dart';
import 'package:medfind_flutter/Presentation/Screens/Authentication/login.dart';
import 'package:medfind_flutter/Presentation/Screens/Authentication/signup.dart';
import 'package:medfind_flutter/Presentation/Screens/MedicineSearch/home.dart';
import 'package:medfind_flutter/Presentation/Screens/MedicineSearch/search_result.dart';
import 'package:medfind_flutter/Presentation/Screens/WatchList/watchlist_screen.dart';
import 'package:medfind_flutter/Presentation/Screens/reservation/reservation.dart';
import 'package:medfind_flutter/Presentation/_Shared/Widgets/bottom_navigation_bar.dart';

import 'package:medfind_flutter/Presentation/splash_screen.dart';

import '../Screens/Admin/admin_screen.dart';
import '../Screens/Admin/user_detail_update.dart';

class MedfindRouter {
  // ignore: unused_fiel
  static final GoRouter router = GoRouter(
    initialLocation: "/reservation",
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) => Home(),
      ),
      GoRoute(
        path: '/search',
        builder: (BuildContext context, GoRouterState state) =>
            const SearchResult(),
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (BuildContext context, GoRouterState state) =>
            const SignUpPage(),
      ),
      GoRoute(
        path: '/reservation',
        builder: (BuildContext context, GoRouterState state) =>
            const ReservationScreen(),
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
      ),
      GoRoute(
        path: "/admin/user_details",
        builder: (BuildContext context, GoRouterState state) =>
            UserDetailUpdateScreen(
          user: state.extra! as User,
        ),
      ),
      GoRoute(
        path: "/admin/pharmacy_details",
        builder: (BuildContext context, GoRouterState state) =>
            PharmacyDetailUpdateScreen(
          pharmacy: state.extra! as APharmacy,
        ),
      ),
      GoRoute(
        path: '/watch_list',
        builder: (BuildContext context, GoRouterState state) =>
            WatchListScreen(),
      ),
    ],
  );
}
