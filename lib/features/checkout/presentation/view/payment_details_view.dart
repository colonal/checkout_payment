import 'package:flutter/material.dart';

import '../../../../core/widget/custom_app_bar.dart';
import '../widget/payment_details_view_body.dart';
import 'my_card_view.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "Payment Details",
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const MyCardView()));
              },
              icon: const Icon(Icons.arrow_back))),
      body: const PaymentDetailsViewBody(),
    );
  }
}
