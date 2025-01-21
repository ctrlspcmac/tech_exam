// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionsResponse _$TransactionsResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionsResponse(
      json['id'] as String? ?? '',
      json['receiverAccountId'] as String? ?? '',
      json['senderAccountId'] as String? ?? '',
      json['amount'] as String? ?? '',
      json['transactionDate'] as String? ?? '',
      json['currency'] as String? ?? '',
      json['transactionType'] as String? ?? '',
    );

Map<String, dynamic> _$TransactionsResponseToJson(
   TransactionsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'receiverAccountId': instance.receiverAccountId,
      'senderAccountId': instance.senderAccountId,
      'amount': instance.amount,
      'transactionDate': instance.transactionDate,
      'currency': instance.currency,
      'transactionType': instance.transactionType,
    };
