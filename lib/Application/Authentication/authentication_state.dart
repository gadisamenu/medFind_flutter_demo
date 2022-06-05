import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthUninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

class UnAuthenticated extends AuthenticationState {}

class AuthenticationFailed extends AuthenticationState {}

class Authenticating extends AuthenticationState {}

class SigningUp extends AuthenticationState {}

class SignUpFailed extends AuthenticationState {}
