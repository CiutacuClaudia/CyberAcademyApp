import 'package:json_annotation/json_annotation.dart';

part 'learning_ciphers_request.g.dart';

@JsonSerializable()
class LearningCipher {
  final int id;
  final String subject;
  final String title;
  final List<CipherType> subtitles;

  LearningCipher({
    required this.id,
    required this.subject,
    required this.title,
    required this.subtitles,
  });

  factory LearningCipher.fromJson(Map<String, dynamic> json) =>
      _$LearningCipherFromJson(json);

  Map<String, dynamic> toJson() => _$LearningCipherToJson(this);
}

@JsonSerializable()
class CipherType {
  final int id;
  final String title;
  final List<CipherDetail> subtitles;

  CipherType({required this.id, required this.title, required this.subtitles});

  factory CipherType.fromJson(Map<String, dynamic> json) =>
      _$CipherTypeFromJson(json);

  Map<String, dynamic> toJson() => _$CipherTypeToJson(this);
}

@JsonSerializable()
class CipherDetail {
  final int id;
  final String title;
  final String content;

  CipherDetail({required this.id, required this.title, required this.content});

  factory CipherDetail.fromJson(Map<String, dynamic> json) =>
      _$CipherDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CipherDetailToJson(this);
}
