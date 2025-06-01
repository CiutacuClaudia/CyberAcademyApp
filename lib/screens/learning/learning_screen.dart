import 'package:disertatie/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/routes.dart';
import '../../common/widgets/custom_book_button.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.size_6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomBookButton(
                label: loc.ciphers,
                onPressed:
                    () => context.goNamed(Routes.learningCiphersScreen.name),
              ),
              CustomBookButton(
                label: loc.phishing,
                onPressed:
                    () => context.goNamed(Routes.learningPhishingScreen.name),
              ),
              CustomBookButton(
                label: loc.viruses,
                onPressed:
                    () => context.goNamed(Routes.learningVirusesScreen.name),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
