part of 'admin_bloc.dart';

abstract class AdminState {}

class Idle extends AdminState {}

class Loading extends AdminState {}

class UsersLoaded extends AdminState {
  final List<User> users;
  UsersLoaded(this.users);
}

class PharmaciesLoaded extends AdminState {
  final List<Pharmacy> users;
  PharmaciesLoaded(this.users);
}

class UserLoaded extends AdminState {
  final User user;
  UserLoaded(this.user);
}

class PharmacyLoaded extends AdminState {
  final Pharmacy user;
  PharmacyLoaded(this.user);
}

class LoadingFailed extends AdminState {
  String? msg;
  LoadingFailed({msg});
}
