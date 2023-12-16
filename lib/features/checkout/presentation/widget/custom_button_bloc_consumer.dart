import 'dart:developer';

import '../../data/model/amount_model/amount_model.dart';
import '../../data/model/amount_model/details.dart';
import '../../data/model/payment_intent_input_model/payment_intent_input_model.dart';
import '../manger/cubit/payment_cubit.dart';
import '../view/thank_you_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/enum/payment_method_enum.dart';
import '../../../../core/widget/custom_button.dart';
import '../../data/model/item_list_model/item_list_model.dart';
import '../../data/model/item_list_model/order_item_model.dart';
import '../view/payment_details_view.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  final PaymentMethod paymentMethod;
  const CustomButtonBlocConsumer({required this.paymentMethod, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is Payment) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const ThankYouView()),
            (_) => false,
          );
        } else if (state is PaymentFailure) {
          log("PaymentFailure", error: state.message);
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(content: Text(state.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return CustomButton(
          text: "Continue",
          onTap: () async {
            switch (paymentMethod) {
              case PaymentMethod.stripe:
                const secureStorage = FlutterSecureStorage(
                  aOptions: AndroidOptions(
                    encryptedSharedPreferences: true,
                  ),
                );
                final customerId = await secureStorage.read(key: "customerId");
                log("customerId: $customerId");
                if (context.mounted) {
                  PaymentCubit.get(context).makePayment(
                    paymentIntentInputModel: PaymentIntentInputModel(
                      amount: "100",
                      currency: "usd",
                      customerId: customerId,
                    ),
                  );
                }
              case PaymentMethod.paypal:
                var transitionData = getTransitionData();

                executePaypalPayment(context, transitionData);
              case PaymentMethod.card:
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const PaymentDetailsView()));
            }
          },
          isLoading: state is PaymentLoading,
        );
      },
    );
  }

  void executePaypalPayment(BuildContext context,
      ({AmountModel amountModel, ItemListModel itemListModel}) transitionData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: dotenv.env["CLIENT_Id"],
        secretKey: dotenv.env["CLIENT_SECRET"],
        transactions: [
          {
            "amount": transitionData.amountModel.toJson(),
            "description": "The payment transaction description.",
            // "payment_options": {
            //   "allowed_payment_method":
            //       "INSTANT_FUNDING_SOURCE"
            // },
            "item_list": transitionData.itemListModel.toJson(),
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          Navigator.pop(context);
        },
        onError: (error) {
          log("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          log('cancelled:');
          Navigator.pop(context);
        },
      ),
    ));
  }

  ({AmountModel amountModel, ItemListModel itemListModel}) getTransitionData() {
    AmountModel amountModel = AmountModel(
        total: "100",
        currency: "USD",
        details: Details(
          subtotal: "100",
          shipping: "0",
          shippingDiscount: 0,
        ));

    List<OrderItemModel> order = [
      OrderItemModel(name: "Apple", quantity: 4, price: "10", currency: "USD"),
      OrderItemModel(
          name: "Pineapple", quantity: 5, price: "12", currency: "USD"),
    ];
    ItemListModel itemListModel = ItemListModel(order: order);
    return (amountModel: amountModel, itemListModel: itemListModel);
  }
}
