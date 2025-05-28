import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../common/widgets/custom_button_widget.dart';
import '../../utils/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showJoinDialog(BuildContext context, AppLocalizations loc) {
    final codeController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (_) => StatefulBuilder(
            builder: (context, setState) {
              final isSixDigits = codeController.text.length == 6;

              return AlertDialog(
                title: Text(loc.enterSessionCode),
                content: TextField(
                  controller: codeController,
                  decoration: InputDecoration(
                    hintText: loc.sessionCodeHint,
                    counterText: '',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  onChanged: (_) => setState(() {}),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 4.0),
                    child: Opacity(
                      opacity: isSixDigits ? 1.0 : 0.5,
                      child: IgnorePointer(
                        ignoring: !isSixDigits,
                        child: CustomButtonWidget(
                          label: loc.join,
                          onPressed: () {
                            Navigator.of(context).pop();
                            final code = codeController.text;
                            context.go('/home/phishingScreen?userCode=$code');
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: 140,
              height: 36,
              child: CustomButtonWidget(
                label: loc.joinGameSession,
                onPressed: () => _showJoinDialog(context, loc),
              ),
            ),
          ),
        ],
      ),
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
