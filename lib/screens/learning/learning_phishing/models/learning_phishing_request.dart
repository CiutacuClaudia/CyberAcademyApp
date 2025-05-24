import 'package:json_annotation/json_annotation.dart';

part 'learning_phishing_request.g.dart';

@JsonSerializable()
class PhishingCard {
  final int id;
  final String frontText;
  final String backText;

  PhishingCard({
    required this.id,
    required this.frontText,
    required this.backText,
  });

  factory PhishingCard.fromJson(Map<String, dynamic> json) =>
      _$PhishingCardFromJson(json);

  Map<String, dynamic> toJson() => _$PhishingCardToJson(this);
}
