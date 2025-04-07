// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  accessToken: json['accessToken'] as String?,
  refreshToken: json['refreshToken'] as String?,
  uuid: json['uuid'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'uuid': instance.uuid,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
};
