// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phishing_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhishingRequest _$PhishingRequestFromJson(Map<String, dynamic> json) =>
    PhishingRequest(
      uuid: json['uuid'] as String,
      emailSubject: json['emailSubject'] as String,
      parts:
          (json['parts'] as List<dynamic>)
              .map((e) => PhishingPart.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$PhishingRequestToJson(PhishingRequest instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'emailSubject': instance.emailSubject,
      'parts': instance.parts.map((e) => e.toJson()).toList(),
    };

PhishingPart _$PhishingPartFromJson(Map<String, dynamic> json) => PhishingPart(
  text: json['text'] as String,
  reason: json['reason'] as String?,
  phishing: json['phishing'] as bool,
);

Map<String, dynamic> _$PhishingPartToJson(PhishingPart instance) =>
    <String, dynamic>{
      'text': instance.text,
      'reason': instance.reason,
      'phishing': instance.phishing,
    };
