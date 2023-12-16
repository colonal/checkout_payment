import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/stripe_service.dart';
import '../../data/repos/checkout_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/custom_button.dart';
import '../manger/cubit/payment_cubit.dart';
import 'cart_info_item.dart';
import 'payment_methods_bottom_sheet.dart';
import 'tootle_price.dart';

class MyCartViewBody extends StatelessWidget {
  const MyCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 18),
          Expanded(child: Image.asset("assets/images/basket_image.png")),
          const SizedBox(height: 25),
          const OrderInfoItem(title: "Order Subtotal", value: "\$42.97"),
          const SizedBox(height: 3),
          const OrderInfoItem(title: "Discount", value: "\$0"),
          const SizedBox(height: 3),
          const OrderInfoItem(title: "Shipping", value: "\$8"),
          const Divider(
            endIndent: 10,
            indent: 10,
            thickness: 2,
            height: 34,
            color: Color(0xFFC6C6C6),
          ),
          const TootlePrice(title: "Total", value: "\$50.97"),
          const SizedBox(height: 16),
          CustomButton(
              text: 'Complete Payment',
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BlocProvider<PaymentCubit>(
                        create: (context) => PaymentCubit(
                          checkoutRepo: CheckoutRepoImpl(
                            service: StripeService(
                              apiService: ApiService(),
                            ),
                          ),
                        ),
                        child: const PaymentMethodsBottomSheet(),
                      );
                    });
              }),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
