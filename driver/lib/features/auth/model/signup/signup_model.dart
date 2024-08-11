class UserSignup {
  UserSignup({
    required this.fullname,
    required this.email,
    required this.password,
    required this.vehicleNumber,
    required this.vehicleType,
  });
  final String fullname;
  final String email;
  final String password;
  final String vehicleNumber;
  final String vehicleType;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["fullname"] = fullname;
    data["email"] = email;
    data["password"] = password;
    data["vehicle_no"] = vehicleNumber;
    data["vehicle_type"] = vehicleType;

    return data;
  }
}
