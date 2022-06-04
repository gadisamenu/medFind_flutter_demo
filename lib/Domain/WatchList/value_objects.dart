import 'package:equatable/equatable.dart';
import 'package:medfind_flutter/Domain/_Shared/common.dart';
import 'package:medfind_flutter/Domain/_Shared/value_object_interface.dart';

class MedicineName extends ValueObject<String>
    implements Validatable, Equatable {
  const MedicineName(String value) : super(value);

  @override
  bool isValid() {
    // TODO: implement isValid
    // throw UnimplementedError();
    return true;
  }

  @override
  List<Object?> get props => [super.get()];

  @override
  bool? get stringify => true;
}
