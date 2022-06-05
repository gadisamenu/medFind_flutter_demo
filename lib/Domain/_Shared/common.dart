import 'package:flutter/material.dart';
import 'package:medfind_flutter/Infrastructure/WatchList/DataSource/_watchlist_data_provider.dart';

abstract class Validatable {
  bool isValid();
}

// abstract class Error {}

// class InvalidValueError implements Error {}
class InvalidValueException extends CustomException{
  InvalidValueException(String message) : super(message);
}
