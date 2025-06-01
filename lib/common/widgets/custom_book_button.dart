import 'package:flutter/material.dart';
import '../../utils/dimensions.dart';

class CustomBookButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomBookButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: Dimensions.size_2),
        padding: const EdgeInsets.all(Dimensions.size_4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(Dimensions.size_2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Book spine indicator
            Container(
              width: Dimensions.size_2,
              height: Dimensions.size_10,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.scrim,
                borderRadius: BorderRadius.circular(Dimensions.size_1),
              ),
            ),
            SizedBox(width: Dimensions.size_3),
            // Book cover and title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.scrim,
                    ),
                  ),
                  SizedBox(height: Dimensions.size_1),
                  Container(
                    height: Dimensions.size_2,
                    width: Dimensions.size_15,
                    color: Theme.of(context).colorScheme.scrim,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: Dimensions.size_4,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ],
        ),
      ),
    );
  }
}
