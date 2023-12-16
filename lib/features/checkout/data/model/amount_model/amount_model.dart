import 'details.dart';

class AmountModel {
  final String total;
  final String currency;
  final Details details;

  AmountModel(
      {required this.total, required this.currency, required this.details});

  factory AmountModel.fromJson(Map<String, dynamic> json) => AmountModel(
        total: json['total'].toString(),
        currency: json['currency'].toString(),
        details: Details.fromJson(Map<String, dynamic>.from(json['details'])),
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'currency': currency,
        'details': details.toJson(),
      };
}
