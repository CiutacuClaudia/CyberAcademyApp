import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String? accessToken;
  final String? refreshToken;
  final String uuid;
  final String firstName;
  final String lastName;
  final String email;
  @JsonKey(name: 'isAdmin')
  final bool isAdmin;
  final String userCode;

  User({
    this.accessToken,
    this.refreshToken,
    required this.uuid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isAdmin,
    required this.userCode,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
