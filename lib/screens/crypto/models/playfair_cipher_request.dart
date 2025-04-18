import 'package:json_annotation/json_annotation.dart';

part 'playfair_cipher_request.g.dart';

@JsonSerializable()
class PlayfairCipher{
  final String uuid;
  final String plainText;
  final String key;
  final String encryptedText;

  PlayfairCipher({
    required this.uuid,
    required this.plainText,
    required this.key,
    required this.encryptedText,
  });

  factory PlayfairCipher.fromJson(Map<String, dynamic> json) =>
      _$PlayfairCipherFromJson(json);

  Map<String, dynamic> toJson() => _$PlayfairCipherToJson(this);
}
