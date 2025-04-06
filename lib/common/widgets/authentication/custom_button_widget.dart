import 'package:flutter/material.dart';

import '../../../utils/dimensions.dart';

class CustomButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.size_2),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.scrim,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.size_2),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
