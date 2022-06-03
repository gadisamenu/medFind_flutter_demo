import 'package:medfind_flutter/Domain/_Shared/common.dart';
import 'package:medfind_flutter/Domain/_Shared/value_object_interface.dart';

class MedicineName extends ValueObject implements Validatable {
  const MedicineName(String value) : super(value);

  @override
  bool isValid() {
    // TODO: implement isValid
    throw UnimplementedError();
  }
}
