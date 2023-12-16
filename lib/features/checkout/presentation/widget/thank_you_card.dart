import '../../../../core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'card_info_widget.dart';
import 'payment_item_info.dart';
import 'tootle_price.dart';

class ThankYouCard extends StatelessWidget {
  const ThankYouCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: const Color(0xFFEDEDED),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 50 + 16, left: 24, right: 24),
        child: Column(
          children: [
            const Text(
              'Thank you!',
              textAlign: TextAlign.center,
              style: Styles.style25,
            ),
            Text(
              'Your transaction was successful',
              textAlign: TextAlign.center,
              style: Styles.style20,
            ),
            const SizedBox(height: 42),
            const PaymentItemInfo(title: 'Date', value: '01/24/2023'),
            const SizedBox(height: 20),
            const PaymentItemInfo(title: "Time", value: "10:15 AM"),
            const SizedBox(height: 20),
            const PaymentItemInfo(title: "To", value: "Sam Louis"),
            const Divider(thickness: 2, height: 60),
            const TootlePrice(title: "Total", value: "\$50.97"),
            const SizedBox(height: 30),
            const CardInfoWidget(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  FontAwesomeIcons.barcode,
                  size: 64,
                ),
                Container(
                  height: 58,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 29, vertical: 14),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 1.50, color: Color(0xFF34A853)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'PAID',
                    textAlign: TextAlign.center,
                    style:
                        Styles.style24.copyWith(color: const Color(0xFF34A853)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: (MediaQuery.sizeOf(context).height * .2 + 20) / 2 - 29,
            ),
          ],
        ),
      ),
    );
  }
}
