import 'package:json_annotation/json_annotation.dart';

part 'phishing_reason_request.g.dart';

@JsonSerializable(explicitToJson: true)
class PhishingReasonRequest {
  final int id;
  final String description;

  PhishingReasonRequest({required this.id, required this.description});

  factory PhishingReasonRequest.fromJson(Map<String, dynamic> json) =>
      _$PhishingReasonRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PhishingReasonRequestToJson(this);
}
