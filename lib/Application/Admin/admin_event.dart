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
  final String role;
  ChangerRole(this.role);
}

class LoadPharmacies extends AdminEvent {}

class UpdatePharmacy extends AdminEvent {
  final Pharmacy pharmacy;
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
