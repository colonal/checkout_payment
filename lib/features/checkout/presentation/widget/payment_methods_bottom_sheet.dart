import 'package:flutter/material.dart';

import '../../../../core/enum/payment_method_enum.dart';
import 'custom_button_bloc_consumer.dart';
import 'payment_methods_list_view.dart';

class PaymentMethodsBottomSheet extends StatefulWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  State<PaymentMethodsBottomSheet> createState() =>
      _PaymentMethodsBottomSheetState();
}

class _PaymentMethodsBottomSheetState extends State<PaymentMethodsBottomSheet> {
  PaymentMethod selectPaymentMethod = PaymentMethod.stripe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          PaymentMethodsListView(
            onSelectPaymentMethod: (select) {
              setState(() {
                selectPaymentMethod = select;
              });
            },
          ),
          const SizedBox(height: 32),
          CustomButtonBlocConsumer(paymentMethod: selectPaymentMethod),
        ],
      ),
    );
  }
}
