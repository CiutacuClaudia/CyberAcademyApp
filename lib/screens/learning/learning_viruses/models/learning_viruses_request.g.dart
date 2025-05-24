// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_viruses_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningViruses _$LearningVirusesFromJson(Map<String, dynamic> json) =>
    LearningViruses(
      id: (json['id'] as num).toInt(),
      subject: json['subject'] as String,
      title: json['title'] as String,
      subtitles:
          (json['subtitles'] as List<dynamic>)
              .map((e) => VirusesType.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$LearningVirusesToJson(LearningViruses instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'title': instance.title,
      'subtitles': instance.subtitles,
    };

VirusesType _$VirusesTypeFromJson(Map<String, dynamic> json) => VirusesType(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  subtitles:
      (json['subtitles'] as List<dynamic>)
          .map((e) => VirusesDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$VirusesTypeToJson(VirusesType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitles': instance.subtitles,
    };

VirusesDetail _$VirusesDetailFromJson(Map<String, dynamic> json) =>
    VirusesDetail(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$VirusesDetailToJson(VirusesDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
    };
