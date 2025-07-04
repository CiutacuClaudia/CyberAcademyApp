import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../common/widgets/custom_drop_down.dart';
import '../../../../common/widgets/video_asset.dart';
import '../../../../utils/dimensions.dart';
import '../models/learning_ciphers_request.dart';

class LearningCipherDetailScreen extends StatefulWidget {
  final CipherType cipherType;

  const LearningCipherDetailScreen({super.key, required this.cipherType});

  @override
  _LearningCipherDetailScreenState createState() =>
      _LearningCipherDetailScreenState();
}

class _LearningCipherDetailScreenState
    extends State<LearningCipherDetailScreen> {
  int? _openIndex;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final items = widget.cipherType.subtitles;

    return Scaffold(
      appBar: AppBar(title: Text(widget.cipherType.title)),
      body: ListView.builder(
        padding: const EdgeInsets.all(Dimensions.size_4),
        itemCount: items.length,
        itemBuilder: (ctx, i) {
          final detail = items[i];
          final isVideo =
              detail.content.trim().toLowerCase() == loc.videoPlaceholder;
          final child =
              isVideo
                  ? AssetVideoPlayer(
                    assetPath:
                    'assets/videos/playfair_cipher_example.mp4',
                  )
                  : Text(
                    detail.content,
                    style: Theme.of(context).textTheme.bodySmall,
                  );

          return CustomBookDropdown(
            title: detail.title,
            isExpanded: _openIndex == i,
            onExpansionChanged:
                (open) => setState(() => _openIndex = open ? i : null),
            startColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
            endColor: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
            child: child,
          );
        },
      ),
    );
  }
}
