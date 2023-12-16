class EphemeralKeysInputModel {
  final String customer;

  EphemeralKeysInputModel({required this.customer});

  toJson() {
    return {
      "customer": customer,
    };
  }
}
