// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phishing_reason_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhishingReasonRequest _$PhishingReasonRequestFromJson(
  Map<String, dynamic> json,
) => PhishingReasonRequest(
  id: (json['id'] as num).toInt(),
  description: json['description'] as String,
);

Map<String, dynamic> _$PhishingReasonRequestToJson(
  PhishingReasonRequest instance,
) => <String, dynamic>{'id': instance.id, 'description': instance.description};
