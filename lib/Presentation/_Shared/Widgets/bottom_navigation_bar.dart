import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar({Key? key}) : super(key: key);
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // backgroundColor: Colors.cyanAccent,
      selectedItemColor: Colors.cyan,
      unselectedItemColor: Colors.cyan,
      currentIndex: currentIndex,
      onTap: (value) {},
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
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: "profile",
        )
      ],
    );
  }
}
