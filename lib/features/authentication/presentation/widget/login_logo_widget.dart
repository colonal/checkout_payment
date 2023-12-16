import 'package:flutter/material.dart';

class LoginLogoWidget extends StatelessWidget {
  const LoginLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height * .4,
      child: Center(
        child: Image.asset(
          "assets/images/checkout.png",
          height: size.height * .3,
        ),
      ),
    );
  }
}
