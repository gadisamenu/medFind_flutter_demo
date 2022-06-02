import 'package:flutter/material.dart';
import 'package:medfind_flutter/Presentation/Screens/config/size_config.dart';

import '../constants.dart';



class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.press
  }) : super(key: key);

  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateHeight(56),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor : mPrimaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateWidth(10),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}