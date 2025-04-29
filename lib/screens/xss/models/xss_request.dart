import 'package:json_annotation/json_annotation.dart';

part 'xss_request.g.dart';

@JsonSerializable(explicitToJson: true)
class XssRequest {
  final String id;
  final String blogContent;
  final List<String> comments;
  final String flag;

  XssRequest({
    required this.id,
    required this.blogContent,
    required this.comments,
    required this.flag,
  });

  factory XssRequest.fromJson(Map<String, dynamic> json) =>
      _$XssRequestFromJson(json);

  Map<String, dynamic> toJson() => _$XssRequestToJson(this);
}
