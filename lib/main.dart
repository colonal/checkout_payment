import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'features/authentication/presentation/view/login_screen.dart';
import 'features/checkout/presentation/view/my_card_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = dotenv.env["PUBLISHABLE_KEY"]!;
  const secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );
  final token = await secureStorage.read(key: "token");

  runApp(CheckoutApp(token));
}

class CheckoutApp extends StatelessWidget {
  final String? token;
  const CheckoutApp(this.token, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == null ? const LoginScreen() : const MyCardView(),
    );
  }
}
