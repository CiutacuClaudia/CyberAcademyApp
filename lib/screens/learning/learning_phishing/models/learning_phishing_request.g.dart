// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_phishing_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhishingCard _$PhishingCardFromJson(Map<String, dynamic> json) => PhishingCard(
  id: (json['id'] as num).toInt(),
  frontText: json['frontText'] as String,
  backText: json['backText'] as String,
);

Map<String, dynamic> _$PhishingCardToJson(PhishingCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'frontText': instance.frontText,
      'backText': instance.backText,
    };
