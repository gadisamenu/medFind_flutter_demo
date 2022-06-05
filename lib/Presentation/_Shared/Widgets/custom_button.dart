import 'package:flutter/material.dart';
import 'package:medfind_flutter/Presentation/Screens/config/size_config.dart';

import '../constants.dart';

ElevatedButton getButton(
    double width, double height, Widget child, Function function,
    {Color color = Colors.blue}) {
  // print(function);
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(color),
      fixedSize: MaterialStateProperty.all<Size>(Size(width, height)),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    ),
    onPressed: () {
      // print("pressed ${function}");
      function();
    },
    child: child,
  );
}
