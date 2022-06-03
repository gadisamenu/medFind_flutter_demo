
import 'package:flutter/material.dart';

abstract class Validatable<@required T> {
  bool isValid(T input);
}

abstract class Error {}

class InvalidValueError implements Error{

}
