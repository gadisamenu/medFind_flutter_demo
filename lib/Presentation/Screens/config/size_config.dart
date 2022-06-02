import 'package:flutter/material.dart';


class SizeConfig{
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  static void initialize(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    
    screenHeight = _mediaQueryData.size.width;
    screenWidth = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

double getProportionateHeight(double inputHeight){
  double screenHeight = SizeConfig.screenHeight;
  return (inputHeight / 800.0) * screenHeight;
}

double getProportionateWidth(double inputWidth){
  double screenWidth = SizeConfig.screenWidth;
  return (inputWidth / 350.0) * screenWidth;
}