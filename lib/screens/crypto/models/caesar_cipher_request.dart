import 'package:json_annotation/json_annotation.dart';

part 'caesar_cipher_request.g.dart';

@JsonSerializable()
class CaesarCipher {
  final String uuid;
  final String plainText;
  final int key;
  final String encryptedText;

  CaesarCipher({
    required this.uuid,
    required this.plainText,
    required this.key,
    required this.encryptedText,
  });

  factory CaesarCipher.fromJson(Map<String, dynamic> json) =>
      _$CaesarCipherFromJson(json);

  Map<String, dynamic> toJson() => _$CaesarCipherToJson(this);
}
