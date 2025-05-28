import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/dimensions.dart';
import '../../phishing/models/phishing_request.dart';

class PhishingPreview extends StatelessWidget {
  final String subject;
  final List<PhishingPart> parts;

  const PhishingPreview({
    super.key,
    required this.subject,
    required this.parts,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${loc.subject}: $subject',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: Dimensions.size_2),
          Text(loc.email, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: Dimensions.size_2),
          Wrap(
            spacing: Dimensions.size_0_5,
            runSpacing: Dimensions.size_0_5,
            children:
                parts.map((p) {
                  final bg =
                      p.phishing ? Colors.red.shade100 : Colors.grey.shade200;
                  return Container(
                    padding: const EdgeInsets.all(Dimensions.size_1),
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(Dimensions.size_1),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Text(
                      p.text,
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            p.phishing ? Colors.red.shade900 : Colors.black87,
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
