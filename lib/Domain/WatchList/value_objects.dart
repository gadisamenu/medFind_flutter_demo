import 'package:medfind_flutter/Domain/_Shared/common.dart';
import 'package:medfind_flutter/Domain/_Shared/value_object_interface.dart';

class MedicineName extends ValueObject implements Validatable<String> {
  const MedicineName(String value) : super(value);

  @override
  bool isValid(String input) {
    // TODO: implement isValid
    throw UnimplementedError();
  }
}
