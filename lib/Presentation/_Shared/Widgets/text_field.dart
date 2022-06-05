import 'package:flutter/material.dart';

TextField getTextField(String hintText, double width,
    TextEditingController textFieldController, Function onSubmitted,
    {bool obsecureText = false}) {
  return TextField(
      controller: textFieldController,
      obscureText: obsecureText,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          hintText: hintText, hintStyle: TextStyle(fontSize: 15)),
      onSubmitted: (value) => {
            onSubmitted(),
          });
}
