import 'package:flutter/material.dart';

@immutable
abstract class ValueObject<@required T> {
  final T _value;

  const ValueObject(this._value);

  T get() => _value;
}
