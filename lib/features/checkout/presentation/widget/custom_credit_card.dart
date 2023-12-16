import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CustomCreditCard extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;
  const CustomCreditCard(
      {required this.formKey, required this.autovalidateMode, super.key});

  @override
  State<CustomCreditCard> createState() => _CustomCreditCardState();
}

class _CustomCreditCardState extends State<CustomCreditCard> {
  String cardNumber = "", expiryDate = "", cardHolderName = "", cvvCode = "";

  bool showBackView = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: showBackView,
            isHolderNameVisible: true,
            onCreditCardWidgetChange: (CreditCardBrand cardBrand) {},
          ),
          CreditCardForm(
            autovalidateMode: widget.autovalidateMode,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            onCreditCardModelChange: (CreditCardModel cardModel) {
              cardNumber = cardModel.cardNumber;
              expiryDate = cardModel.expiryDate;
              cardHolderName = cardModel.cardHolderName;
              cvvCode = cardModel.cvvCode;
              showBackView = cardModel.isCvvFocused;
              setState(() {});
            },
            formKey: widget.formKey,
          ),
        ],
      ),
    );
  }
}
