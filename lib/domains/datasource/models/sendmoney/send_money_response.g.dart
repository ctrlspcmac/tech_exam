// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_money_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMoneyResponse _$SendMoneyResponseFromJson(
        Map<String, dynamic> json) =>
    SendMoneyResponse(
      json['id'] as String? ?? '',
      json['transactionDate'] as String? ?? '',
    );

Map<String, dynamic> _$SendMoneyResponseToJson(
    SendMoneyResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transactionDate': instance.transactionDate,
    };
