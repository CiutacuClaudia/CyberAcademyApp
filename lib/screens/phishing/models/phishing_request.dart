import 'package:json_annotation/json_annotation.dart';

part 'phishing_request.g.dart';

@JsonSerializable(explicitToJson: true)
class PhishingRequest {
  final String uuid;
  final String emailSubject;
  final List<PhishingPart> parts;

  PhishingRequest({
    required this.uuid,
    required this.emailSubject,
    required this.parts,
  });

  factory PhishingRequest.fromJson(Map<String, dynamic> json) =>
      _$PhishingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PhishingRequestToJson(this);
}

@JsonSerializable()
class PhishingPart {
  final String text;
  final String? reason;
  final bool phishing;

  PhishingPart({required this.text, this.reason, required this.phishing});

  factory PhishingPart.fromJson(Map<String, dynamic> json) =>
      _$PhishingPartFromJson(json);

  Map<String, dynamic> toJson() => _$PhishingPartToJson(this);
}
