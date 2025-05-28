import '../../phishing/models/phishing_reason_request.dart';
import 'create_phishing_part.dart';

class CreatePhishingRequest {
  final String emailSubject;
  final List<CreatePhishingPart> parts;
  final List<PhishingReasonRequest> reasons;

  CreatePhishingRequest({
    required this.emailSubject,
    required this.parts,
    required this.reasons,
  });

  Map<String, dynamic> toJson() => {
    'emailSubject': emailSubject,
    'parts':
        parts.map((p) {
          final desc =
              p.isPhishing
                  ? reasons.firstWhere((r) => r.id == p.reasonId).description
                  : '';
          return {'text': p.text, 'phishing': p.isPhishing, 'reason': desc};
        }).toList(),
  };
}
