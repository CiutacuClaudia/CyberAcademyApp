import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  final String email;

  ResetPasswordRequest({required this.email});

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);
}
