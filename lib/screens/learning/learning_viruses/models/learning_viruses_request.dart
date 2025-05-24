import 'package:json_annotation/json_annotation.dart';

part 'learning_viruses_request.g.dart';

@JsonSerializable()
class LearningViruses {
  final int id;
  final String subject;
  final String title;
  final List<VirusesType> subtitles;

  LearningViruses({
    required this.id,
    required this.subject,
    required this.title,
    required this.subtitles,
  });

  factory LearningViruses.fromJson(Map<String, dynamic> json) =>
      _$LearningVirusesFromJson(json);

  Map<String, dynamic> toJson() => _$LearningVirusesToJson(this);
}

@JsonSerializable()
class VirusesType {
  final int id;
  final String title;
  final List<VirusesDetail> subtitles;

  VirusesType({required this.id, required this.title, required this.subtitles});

  factory VirusesType.fromJson(Map<String, dynamic> json) =>
      _$VirusesTypeFromJson(json);

  Map<String, dynamic> toJson() => _$VirusesTypeToJson(this);
}

@JsonSerializable()
class VirusesDetail {
  final int id;
  final String title;
  final String content;

  VirusesDetail({required this.id, required this.title, required this.content});

  factory VirusesDetail.fromJson(Map<String, dynamic> json) =>
      _$VirusesDetailFromJson(json);

  Map<String, dynamic> toJson() => _$VirusesDetailToJson(this);
}
