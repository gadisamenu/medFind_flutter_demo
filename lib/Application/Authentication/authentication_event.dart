import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class Login extends AuthenticationEvent {
  final String email;
  final String password;

  Login({required this.email, required this.password});
}

class Logout extends AuthenticationEvent {
  @override
  String toString() => 'Logged Out';
}

class Signup extends AuthenticationEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  Signup(this.firstName, this.lastName, this.email, this.password);
}
