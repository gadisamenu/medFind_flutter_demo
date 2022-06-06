import 'package:flutter_test/flutter_test.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_bloc.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_event.dart';
import 'package:medfind_flutter/Application/Authentication/authentication_state.dart';
import 'package:medfind_flutter/Infrastructure/Authentication/DataSource/remote_data_provider.dart';
import 'package:medfind_flutter/Infrastructure/Authentication/Repository/auth_repository.dart';

void main() async {
  group('Authentication Repository Test', () {
    late AuthenticationBloc authBloc;
    late AuthRepository authRepo;

    const authenticating = TypeMatcher<Authenticating>();
    const authenticated = TypeMatcher<Authenticated>();
    const unauthenticated = TypeMatcher<UnAuthenticated>();
    const authfailed = TypeMatcher<AuthenticationFailed>();
    const signingup = TypeMatcher<SigningUp>();
    const signupfailed = TypeMatcher<SignUpFailed>();
    setUp(() {
      authRepo = AuthRepository(AuthDataProvider());
      authBloc = AuthenticationBloc(authRepo);
    });
    test('initial state is AuthUninitialized', () {
      expect(authBloc.state, AuthUninitialized());
    });
    test('emits [UnAuthenticated] when app starts', () async {
      authRepo.deleteToken();
      authBloc.add(AppStarted());
      await expectLater(authBloc.stream, emitsInOrder([unauthenticated]));
    });

    test('emits [Authenticating, Authenticated] when login authenticatedful',
        () async {
      authBloc
          .add(Login(email: 'kkmichaelstarkk@gmail.com', password: '12345678'));
      await expectLater(
          authBloc.stream, emitsInOrder([authenticating, authenticated]));
    });

    test(
        'emits [Authenticating, AuthenticationFailed] when login unauthenticatedful',
        () async {
      authBloc.add(
          Login(email: 'kkmichaelstarkk@gmail.com', password: '123456789'));
      await expectLater(
          authBloc.stream, emitsInOrder([authenticating, authfailed]));
    });

    test('emits [Authenticating, UnAuthenticated] when logout authenticatedful',
        () async {
      authBloc
          .add(Login(email: 'kkmichaelstarkk@gmail.com', password: '12345678'));
      authBloc.add(Logout());
      await expectLater(
          authBloc.stream, emitsInOrder([authenticating, unauthenticated]));
    });

    test('emits [Authenticating, UnAuthenticated] when signup successful',
        () async {
      authBloc.add(
          Signup("bruce", "banner", "brbban@gmail.com", '12345678', "USER"));
      await expectLater(
          authBloc.stream, emitsInOrder([signingup, unauthenticated]));
    });

    test('emits [Authenticating, SignupFailed] when signup unsuccessful',
        () async {
      authBloc.add(Signup(
          "bruce", "banner", "kkmichaelstarkk@gmail.com", '12345678', "USER"));
      await expectLater(
          authBloc.stream, emitsInOrder([signingup, signupfailed]));
    });
  });
}
