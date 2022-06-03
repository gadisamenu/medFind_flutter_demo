class User {
  int? id;
  String firstName;
  String lastName;
  String email;

  User(
      {required this.email,
      required this.firstName,
      required this.lastName,
      this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }
}
