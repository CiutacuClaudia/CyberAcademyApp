// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xss_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XssRequest _$XssRequestFromJson(Map<String, dynamic> json) => XssRequest(
  id: json['id'] as String,
  blogContent: json['blogContent'] as String,
  comments:
      (json['comments'] as List<dynamic>).map((e) => e as String).toList(),
  flag: json['flag'] as String,
);

Map<String, dynamic> _$XssRequestToJson(XssRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'blogContent': instance.blogContent,
      'comments': instance.comments,
      'flag': instance.flag,
    };
