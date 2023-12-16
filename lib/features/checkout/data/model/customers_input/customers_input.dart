class CustomerInputModel {
  final String name;
  final String email;
  final String? phone;

  CustomerInputModel({required this.name, required this.email, this.phone});

  Map toJson() {
    return {"name": name, "email": email, "phone": phone};
  }
}
