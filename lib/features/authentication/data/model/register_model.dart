class RegisterModel {
  final String name;
  final String email;
  final String password;
  final String confirmation;
  final String phone;

  RegisterModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "password_confirmation": confirmation,
    };
  }
}
