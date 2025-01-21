// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_money_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendReceiveMoneyRequest _$SendReceiveMoneyRequestFromJson(
        Map<String, dynamic> json) =>
    SendReceiveMoneyRequest(
      receiverAccountId: json['receiverAccountId'] as String? ?? '',
      senderAccountId: json['senderAccountId'] as String? ?? '',
      amount: json['amount'] as String? ?? '',
      transactionDate: json['transactionDate'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
      transactionType: json['transactionType'] as String? ?? '',
    );

Map<String, dynamic> _$SendReceiveMoneyRequestToJson(
        SendReceiveMoneyRequest instance) =>
    <String, dynamic>{
      'receiverAccountId': instance.receiverAccountId,
      'senderAccountId': instance.senderAccountId,
      'amount': instance.amount,
      'transactionDate': instance.transactionDate,
      'currency': instance.currency,
      'transactionType': instance.transactionType,
    };
