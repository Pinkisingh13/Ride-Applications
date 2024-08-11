class UserSignup {
  UserSignup({
    required this.fullname,
    required this.email,
    required this.password,
  });
 final String fullname;
  final String email;

  final String password;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["fullname"] = fullname;
    data["email"] = email;
    data["password"] = password;

    return data;
  }
}
