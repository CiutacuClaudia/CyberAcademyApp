// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playfair_cipher_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayfairCipher _$PlayfairCipherFromJson(Map<String, dynamic> json) =>
    PlayfairCipher(
      uuid: json['uuid'] as String,
      plainText: json['plainText'] as String,
      key: json['key'] as String,
      encryptedText: json['encryptedText'] as String,
    );

Map<String, dynamic> _$PlayfairCipherToJson(PlayfairCipher instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'plainText': instance.plainText,
      'key': instance.key,
      'encryptedText': instance.encryptedText,
    };
