import 'package:flutter/material.dart';
import '../../utils/dimensions.dart';

class CustomBookDropdown extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isExpanded;
  final ValueChanged<bool>? onExpansionChanged;
  final Color startColor;
  final Color endColor;

  const CustomBookDropdown({
    super.key,
    required this.title,
    required this.child,
    this.isExpanded = false,
    this.onExpansionChanged,
    required this.startColor,
    required this.endColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimensions.size_2),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor, endColor]),
        borderRadius: BorderRadius.circular(Dimensions.size_2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.size_2),
        child: ExpansionTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconColor: Theme.of(context).colorScheme.outlineVariant,
          collapsedIconColor: Theme.of(context).colorScheme.outlineVariant,
          tilePadding: const EdgeInsets.symmetric(
            horizontal: Dimensions.size_4,
            vertical: Dimensions.size_2,
          ),
          childrenPadding: const EdgeInsets.all(Dimensions.size_4),
          backgroundColor: Theme.of(context).colorScheme.surface,
          collapsedBackgroundColor: Colors.transparent,
          onExpansionChanged: onExpansionChanged,
          initiallyExpanded: isExpanded,
          children: [child],
        ),
      ),
    );
  }
}
