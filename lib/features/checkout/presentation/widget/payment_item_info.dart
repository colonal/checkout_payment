import 'package:flutter/material.dart';

import '../../../../core/utils/styles.dart';

class PaymentItemInfo extends StatelessWidget {
  final String title, value;
  const PaymentItemInfo({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: Styles.style18,
        ),
        Text(
          value,
          style: Styles.styleBold18,
        )
      ],
    );
  }
}
