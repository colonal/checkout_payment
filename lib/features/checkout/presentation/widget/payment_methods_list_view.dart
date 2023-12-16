import 'package:flutter/material.dart';

import '../../../../core/enum/payment_method_enum.dart';
import 'payment_method_item.dart';

class PaymentMethodsListView extends StatefulWidget {
  final Function(PaymentMethod) onSelectPaymentMethod;
  const PaymentMethodsListView(
      {required this.onSelectPaymentMethod, super.key});

  @override
  State<PaymentMethodsListView> createState() => _PaymentMethodsListViewState();
}

class _PaymentMethodsListViewState extends State<PaymentMethodsListView> {
  final List<({String image, PaymentMethod paymentMethod})>
      paymentMethodsItems = const [
    (image: "assets/images/stripe.svg", paymentMethod: PaymentMethod.stripe),
    (image: "assets/images/paypal.svg", paymentMethod: PaymentMethod.paypal),
    (image: "assets/images/card.svg", paymentMethod: PaymentMethod.card),
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: paymentMethodsItems.length,
          separatorBuilder: (_, __) => const SizedBox(width: 20),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  activeIndex = index;
                  widget.onSelectPaymentMethod(
                      paymentMethodsItems[index].paymentMethod);
                });
              },
              child: PaymentMethodItem(
                image: paymentMethodsItems[index].image,
                isActive: activeIndex == index,
              ),
            );
          }),
    );
  }
}
