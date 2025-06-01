import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';

class CustomSquareButtonWidget extends StatelessWidget {
  final String label;
  final ImageProvider image;
  final VoidCallback onPressed;
  final double size;

  const CustomSquareButtonWidget({
    super.key,
    required this.label,
    required this.image,
    required this.onPressed,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.size_2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.scrim,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Dimensions.size_1),
            SizedBox(
              height: size * 0.5,
              width: size * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.size_2),
                child: Image(image: image, fit: BoxFit.contain),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
