import '../../../authentication/presentation/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/widget/custom_app_bar.dart';
import '../widget/my_cart_view_body.dart';

class MyCardView extends StatelessWidget {
  const MyCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "My Cart",
          leading: IconButton(
              onPressed: () async {
                await const FlutterSecureStorage().delete(key: "token");
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                }
              },
              icon: const Icon(Icons.logout))),
      body: const MyCartViewBody(),
    );
  }
}
