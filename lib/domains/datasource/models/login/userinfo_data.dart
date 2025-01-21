import 'package:json_annotation/json_annotation.dart';

part 'userinfo_data.g.dart';

@JsonSerializable()
class UserInfoModel {
  UserInfoModel([
    this.userName,
    this.firstName,
    this.lastName,
    this.password,
    this.accountId,
  ]);
  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);

  @JsonKey(defaultValue: '')
  final String? userName;

  @JsonKey(defaultValue: '')
  final String? firstName;

  @JsonKey(defaultValue: '')
  final String? lastName;

  @JsonKey(defaultValue: '')
  final String? password;

  @JsonKey(defaultValue: 0)
  final int? accountId;
}
