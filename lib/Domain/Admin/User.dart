class User {
  int? id;
  String firstName;
  String lastName;
  String email;
  String? password;

  User(this.email, this.firstName, this.lastName, {this.password, this.id});
}
