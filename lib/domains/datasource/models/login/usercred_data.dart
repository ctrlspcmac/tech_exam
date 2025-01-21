import 'package:json_annotation/json_annotation.dart';

part 'usercred_data.g.dart';

@JsonSerializable()
class UserCredentialsModel {
  UserCredentialsModel([
    this.userName,
    this.password,
  ]);

  factory UserCredentialsModel.fromJson(Map<String, dynamic> json) =>
      _$UserCredentialsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserCredentialsModelToJson(this);

  @JsonKey(defaultValue: '')
  final String? userName;

  @JsonKey(defaultValue: '')
  final String? password;

}
