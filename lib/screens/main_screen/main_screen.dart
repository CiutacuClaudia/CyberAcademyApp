import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../common/widgets/authentication/custom_button_widget.dart';
import '../../utils/routes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButtonWidget(
              label: 'Cryptography',
              onPressed: () {
                context.goNamed(Routes.cryptoScreen);
              },
            ),
            CustomButtonWidget(
              label: 'Phishing',
              onPressed: () {
                context.goNamed(Routes.phishingScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
