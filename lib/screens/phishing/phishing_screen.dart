import 'package:flutter/material.dart';

import '../../common/widgets/back_button_widget.dart';

class PhishingScreen extends StatelessWidget {
  const PhishingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: const CustomBackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
