import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final String token;

  LoggedIn({required this.token});

  @override
  String toString() => 'Logged In {token: $token}';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'Logged Out';
}
