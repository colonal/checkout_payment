import 'package:flutter/material.dart';

import '../../../../core/utils/styles.dart';

class OrderInfoItem extends StatelessWidget {
  final String title;
  final String value;
  const OrderInfoItem({required this.title, required this.value, super.key});

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
          textAlign: TextAlign.center,
          style: Styles.style18,
        )
      ],
    );
  }
}
