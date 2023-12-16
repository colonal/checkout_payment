import 'package:flutter/material.dart';

class RegisterLogoWidget extends StatelessWidget {
  const RegisterLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height * .3,
      child: Center(
        child: Image.asset(
          "assets/images/register.png",
          height: size.height * .2,
        ),
      ),
    );
  }
}
