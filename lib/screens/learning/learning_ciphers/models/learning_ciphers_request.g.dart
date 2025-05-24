// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_ciphers_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningCipher _$LearningCipherFromJson(Map<String, dynamic> json) =>
    LearningCipher(
      id: (json['id'] as num).toInt(),
      subject: json['subject'] as String,
      title: json['title'] as String,
      subtitles:
          (json['subtitles'] as List<dynamic>)
              .map((e) => CipherType.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$LearningCipherToJson(LearningCipher instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'title': instance.title,
      'subtitles': instance.subtitles,
    };

CipherType _$CipherTypeFromJson(Map<String, dynamic> json) => CipherType(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  subtitles:
      (json['subtitles'] as List<dynamic>)
          .map((e) => CipherDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$CipherTypeToJson(CipherType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitles': instance.subtitles,
    };

CipherDetail _$CipherDetailFromJson(Map<String, dynamic> json) => CipherDetail(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  content: json['content'] as String,
);

Map<String, dynamic> _$CipherDetailToJson(CipherDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
    };
