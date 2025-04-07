// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_confirm_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordConfirmRequest _$ResetPasswordConfirmRequestFromJson(
  Map<String, dynamic> json,
) => ResetPasswordConfirmRequest(
  code: json['code'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$ResetPasswordConfirmRequestToJson(
  ResetPasswordConfirmRequest instance,
) => <String, dynamic>{
  'code': instance.code,
  'newPassword': instance.newPassword,
};
