class User {
  int? id;
  String firstName;
  String lastName;
  String email;
  String role;
  String? oldPassword;
  String? newPassword;

  User(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.role,
      this.id,
      this.oldPassword,
      this.newPassword});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"].toInt(),
      role: json["roles"][0]["name"],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json.addAll({
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email
    });

    if (oldPassword != null && newPassword != null) {
      json.addAll({'oldPassword': oldPassword, 'newPassword': newPassword});
    }
    return json;
  }
}
