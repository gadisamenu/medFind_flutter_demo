import 'package:flutter/material.dart';

abstract class Validatable {
  bool isValid();
}

abstract class Error {}

class InvalidValueError implements Error {}
