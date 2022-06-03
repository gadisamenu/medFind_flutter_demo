class User {
  int? id;
  String firstName;
  String lastName;
  String email;
  String role;

  User(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.role,
      this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      role: json["role"],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }
}
