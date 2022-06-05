class User {
  String firstName;
  String lastName;
  String email;
  String password;

  User(this.firstName, this.lastName, this.email, this.password);

  factory User.fromJson(Map<String, dynamic> userJson) {
    return User(userJson['firstName'], userJson['lastName'],
        userJson['email'], userJson['password']);
  }
}
