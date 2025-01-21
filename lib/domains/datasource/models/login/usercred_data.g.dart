// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usercred_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCredentialsModel _$UserCredentialsModelFromJson(
        Map<String, dynamic> json) =>
    UserCredentialsModel(
      json['userName'] as String? ?? '',
      json['password'] as String? ?? '',
    );

Map<String, dynamic> _$UserCredentialsModelToJson(
        UserCredentialsModel instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'password': instance.password,
    };
