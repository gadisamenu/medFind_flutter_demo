import 'package:flutter/material.dart';

Container getCard(double width, double height, Widget child,
    {double margin = 10}) {
  return Container(
    width: width,
    height: height,
    margin: EdgeInsets.all(margin),
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue,
            offset: Offset.fromDirection(1.0, 15.0),
            blurRadius: 15,
          )
        ],
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 78, 163, 232),
              Color.fromARGB(255, 205, 230, 230)
            ]),
        borderRadius: BorderRadius.circular(20.0)),
    child: child,
  );
}
