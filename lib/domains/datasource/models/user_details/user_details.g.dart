// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
    json['id'] as String? ?? '',
    json['accountName'] as String? ?? '',
    json['balance'] as String? ?? '');

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountName': instance.accountName,
      'balance': instance.balance
    };
