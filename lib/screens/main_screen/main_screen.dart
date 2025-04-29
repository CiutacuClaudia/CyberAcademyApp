import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../common/widgets/custom_button_widget.dart';
import '../../utils/routes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButtonWidget(
              label: 'Cryptography',
              onPressed: () {
                context.push(Routes.cryptoScreen);
              },
            ),
            CustomButtonWidget(
              label: 'Phishing',
              onPressed: () {
                context.push(Routes.phishingScreen);
              },
            ),
            CustomButtonWidget(
              label: 'Web Browsing Challenge',
              onPressed: () {
                context.push(Routes.xssScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
