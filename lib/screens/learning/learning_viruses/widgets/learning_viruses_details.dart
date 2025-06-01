import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../common/widgets/custom_drop_down.dart';
import '../../../../common/widgets/video_asset.dart';
import '../../../../utils/dimensions.dart';
import '../models/learning_viruses_request.dart';

class LearningVirusesDetailScreen extends StatefulWidget {
  final VirusesType virusesType;

  const LearningVirusesDetailScreen({super.key, required this.virusesType});

  @override
  _LearningVirusesDetailScreenState createState() =>
      _LearningVirusesDetailScreenState();
}

class _LearningVirusesDetailScreenState
    extends State<LearningVirusesDetailScreen> {
  int? _openIndex;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final items = widget.virusesType.subtitles;

    return Scaffold(
      appBar: AppBar(title: Text(widget.virusesType.title)),
      body: ListView.builder(
        padding: const EdgeInsets.all(Dimensions.size_4),
        itemCount: items.length,
        itemBuilder: (ctx, i) {
          final detail = items[i];
          final isVideo =
              detail.content.trim().toLowerCase() == loc.videoPlaceholder;
          final content =
              isVideo
                  ? AssetVideoPlayer(
                    assetPath:
                        'assets/videos/${detail.title.toLowerCase()}_example.mp4',
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
            child: content,
          );
        },
      ),
    );
  }
}
