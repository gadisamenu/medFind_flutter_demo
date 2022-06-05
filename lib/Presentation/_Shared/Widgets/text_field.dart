import 'package:flutter/material.dart';

TextField getTextField(String hintText, double width,
    TextEditingController textFieldController, Function onSubmitted) {
  return TextField(
      controller: textFieldController,
      decoration: InputDecoration(
          hintText: hintText, hintStyle: TextStyle(fontSize: 15)),
      onSubmitted: (value) => {
            onSubmitted(),
          });
}
