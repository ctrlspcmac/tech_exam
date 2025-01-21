// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userinfo_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      json['userName'] as String? ?? '',
      json['firstName'] as String? ?? '',
      json['lastName'] as String? ?? '',
      json['password'] as String? ?? '',
      json['accountId'] as int? ?? 0,
    );

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'password': instance.password,
      'accountId': instance.accountId,
    };
