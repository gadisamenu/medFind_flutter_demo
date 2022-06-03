import 'package:equatable/equatable.dart';
import 'model.dart';

class Identity extends Equatable {
  final String id;
  factory Identity.fromString(String id) {
    return Identity._internal(id);
  }
  Identity._internal(this.id);
  @override
  List<Object> get props => [id];
}

class Pharmacy extends Equatable {
  final Pharmacy pharmacy;
  
}
