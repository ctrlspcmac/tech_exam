import 'package:json_annotation/json_annotation.dart';

part 'user_details.g.dart';

@JsonSerializable()
class UserDetails {
  UserDetails([
    this.id,
    this.accountName,
    this.balance,
  ]);

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);


  @JsonKey(defaultValue: '')
  final String? id;

  @JsonKey(defaultValue: '')
  final String? accountName;

  @JsonKey(defaultValue: '')
  final String? balance;

}