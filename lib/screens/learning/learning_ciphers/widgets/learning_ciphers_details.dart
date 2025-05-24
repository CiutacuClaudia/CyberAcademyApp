import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../common/widgets/video_asset.dart';
import '../../../../utils/dimensions.dart';
import '../models/learning_ciphers_request.dart';

class LearningCipherDetailScreen extends StatelessWidget {
  final CipherType cipherType;

  const LearningCipherDetailScreen({super.key, required this.cipherType});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(cipherType.title)),
      body: ListView(
        children:
            cipherType.subtitles.map((detail) {
              final isVideoPlaceholder =
                  detail.content.trim().toLowerCase() == loc.videoPlaceholder;
              return ExpansionTile(
                title: Text(detail.title),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.size_4),
                    child:
                        isVideoPlaceholder
                            ? AssetVideoPlayer(
                              assetPath:
                                  'assets/videos/playfair_cipher_example.mp4',
                            )
                            : Text(detail.content),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }
}
