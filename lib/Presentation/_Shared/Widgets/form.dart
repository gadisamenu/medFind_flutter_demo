import 'package:flutter/material.dart';

Form getForm(
  Key key,
  Widget child,
) {
  return Form(
    key: key,
    child: child,
  );
}

TextFormField getTextFormField(String labelText, double width,
    TextEditingController textFieldController, Function validator,
    {bool obsecurity = false, String hintText = ""}) {
  return TextFormField(
    validator: (value) => validator(),
    controller: textFieldController,
    cursorColor: Colors.black,
    decoration: InputDecoration(
        iconColor: Colors.black,
        fillColor: Colors.black,
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 15, color: Colors.black)),
    obscureText: obsecurity,
  );
}
