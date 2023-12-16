import '../../../../core/widget/custom_app_bar.dart';
import '../widget/thank_you_view_body.dart';
import 'package:flutter/material.dart';

import 'my_card_view.dart';

class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const MyCardView()));
              },
              icon: const Icon(Icons.arrow_back))),
      body: Transform.translate(
        offset: const Offset(0, -12),
        child: const ThankYouViewBody(),
      ),
    );
  }
}
