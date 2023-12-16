class InitPaymentSheetInputModel {
  final String paymentIntentClientSecret;
  final String? ephemeralKeys;
  final String? customerId;

  InitPaymentSheetInputModel({
    required this.paymentIntentClientSecret,
    this.ephemeralKeys,
    this.customerId,
  });
}
