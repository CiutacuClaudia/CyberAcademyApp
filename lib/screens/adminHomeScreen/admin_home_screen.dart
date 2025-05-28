import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../common/widgets/custom_button_widget.dart';
import '../../utils/routes.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

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
              label: loc.createPhishing,
              onPressed: () {
                context.go(
                  '${Routes.adminHomeScreen.path}/createPhishingGame',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
