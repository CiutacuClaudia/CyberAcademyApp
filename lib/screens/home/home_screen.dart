import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../common/widgets/custom_button_widget.dart';
import '../../utils/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButtonWidget(
              label: loc.cryptography,
              onPressed: () {
                context.go('${Routes.homeScreen.path}/cryptoScreen');
              },
            ),
            CustomButtonWidget(
              label: loc.phishing,
              onPressed: () {
                context.go('${Routes.homeScreen.path}/phishingScreen');
              },
            ),
            CustomButtonWidget(
              label: loc.xssChallenge,
              onPressed: () {
                context.go('${Routes.homeScreen.path}/xssScreen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
