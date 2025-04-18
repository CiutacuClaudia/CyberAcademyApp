// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caesar_cipher_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaesarCipher _$CaesarCipherFromJson(Map<String, dynamic> json) => CaesarCipher(
  uuid: json['uuid'] as String,
  plainText: json['plainText'] as String,
  key: (json['key'] as num).toInt(),
  encryptedText: json['encryptedText'] as String,
);

Map<String, dynamic> _$CaesarCipherToJson(CaesarCipher instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'plainText': instance.plainText,
      'key': instance.key,
      'encryptedText': instance.encryptedText,
    };
