class LoginData {
  LoginData({required this.email, required this.password});
  final String email;
  final String password;


  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["password"] = password;

    return data;
  }
}
