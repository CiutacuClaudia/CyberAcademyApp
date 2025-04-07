import 'package:json_annotation/json_annotation.dart';

part 'reset_password_confirm_request.g.dart';

@JsonSerializable()
class ResetPasswordConfirmRequest {
  final String code;
  final String newPassword;

  ResetPasswordConfirmRequest({required this.code, required this.newPassword});

  factory ResetPasswordConfirmRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordConfirmRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordConfirmRequestToJson(this);
}