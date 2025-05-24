import 'package:disertatie/utils/dimensions.dart';
import 'package:flutter/material.dart';

class FlipCardWidget extends StatefulWidget {
  final String frontText;
  final String backText;

  const FlipCardWidget({
    super.key,
    required this.frontText,
    required this.backText,
  });

  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  bool _showFront = true;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _flip() {
    if (_showFront) {
      _ctrl.forward();
    } else {
      _ctrl.reverse();
    }
    setState(() => _showFront = !_showFront);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          final angle = _ctrl.value * 3.1416;
          final isUnder = angle > 3.1416 / 2;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(angle),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.size_4),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: Dimensions.size_6),
              child: Container(
                height: 250,
                padding: const EdgeInsets.all(Dimensions.size_6),
                alignment: Alignment.center,
                child:
                    isUnder
                        ? Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(3.1416),
                          child: Text(
                            widget.backText,
                            textAlign: TextAlign.center,
                          ),
                        )
                        : Text(widget.frontText, textAlign: TextAlign.center),
              ),
            ),
          );
        },
      ),
    );
  }
}
