part of 'admin_bloc.dart';

abstract class AdminEvent {}

class LoadUsers extends AdminEvent {}

class LoadUser extends AdminEvent {
  final int id;
  LoadUser(this.id);
}

class UpdateUser extends AdminEvent {
  final User user;
  UpdateUser(this.user);
}

class DeleteUser extends AdminEvent {
  final int id;
  DeleteUser(this.id);
}

class ChangerRole extends AdminEvent {
  final int id;
  final String role;
  ChangerRole(this.role, this.id);
}

class LoadPharmacies extends AdminEvent {}

class UpdatePharmacy extends AdminEvent {
  final APharmacy pharmacy;
  UpdatePharmacy(this.pharmacy);
}

class DeletePharmacy extends AdminEvent {
  final int id;
  DeletePharmacy(this.id);
}

class LoadPharmacy extends AdminEvent {
  final int id;
  LoadPharmacy(this.id);
}

class Error extends AdminEvent {
  String? msg;
  dynamic data;
  Error({required this.data, this.msg});
}
