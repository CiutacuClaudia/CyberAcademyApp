import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () {
        if (GoRouter.of(context).canPop()) {
          context.pop();
        } else {
          Navigator.of(context).maybePop();
        }
      },
    );
  }
}
