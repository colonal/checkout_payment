import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PaymentMethodItem extends StatelessWidget {
  final bool isActive;
  final String image;
  const PaymentMethodItem(
      {required this.image, this.isActive = false, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 103,
      height: 62,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.50,
            color: isActive ? const Color(0xFF34A853) : const Color(0x55000080),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: [
          BoxShadow(
            color: isActive ? const Color(0xFF34A853) : const Color(0x55000080),
            blurRadius: 4,
            spreadRadius: 0,
          )
        ],
      ),
      child: Center(
        child: SvgPicture.asset(
          image,
          width: 45,
          height: 30,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
