import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';

class ThemeProvider {}

ThemeData getAppTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    appBarTheme: getAppBarTheme(),
    textTheme: getTextTheme(),
    inputDecorationTheme: getInputDecorationTheme(),
  );
}

InputDecorationTheme getInputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(color: mTextColor),
    gapPadding: 6,
  );
  OutlineInputBorder focusedErrorOutline = OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(
      color: Colors.red,
    ),
    gapPadding: 6,
  );

  return InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 30,
      vertical: 10,
    ),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    focusedErrorBorder: focusedErrorOutline,
    errorBorder: focusedErrorOutline,
  );
}

TextTheme getTextTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: mTextColor),
    bodyText2: TextStyle(color: mTextColor),
  );
}

AppBarTheme getAppBarTheme() {
  return const AppBarTheme(
    centerTitle: true,
    color: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Color(0xFF000000),
      fontSize: 20,
    ),
  );
}
