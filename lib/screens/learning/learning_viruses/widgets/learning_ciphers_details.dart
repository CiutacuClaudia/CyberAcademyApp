import 'package:flutter/material.dart';

import '../../../../utils/dimensions.dart';
import '../models/learning_viruses_request.dart';

class LearningVirusesDetailScreen extends StatelessWidget {
  final VirusesType virusesType;

  const LearningVirusesDetailScreen({super.key, required this.virusesType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(virusesType.title)),
      body: ListView(
        children:
            virusesType.subtitles.map((detail) {
              return ExpansionTile(
                title: Text(detail.title),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.size_4),
                    child: Text(detail.content),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }
}
