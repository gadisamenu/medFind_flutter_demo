import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_bloc.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_state.dart';

class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar({Key? key}) : super(key: key);
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      print("state $state");
      if (state is Authenticated) {
        return BottomNavigationBar(
          // backgroundColor: Colors.cyanAccent,
          selectedItemColor: Color.fromARGB(255, 18, 111, 123),
          unselectedItemColor: Colors.cyan,
          currentIndex: currentIndex,
          onTap: (value) {
            // BlocProvider.of<NavigationBloc>(context).add(Navigate(path: "/home"));
            if (value == 0) {
              context.go("/home");
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "watchlist",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_travel),
              label: "reserved",
            ),
          ],
        );
      } else {
        return SizedBox();
      }
    });
  }
}
