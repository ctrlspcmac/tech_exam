import 'package:json_annotation/json_annotation.dart';

part 'transactions_response.g.dart';

@JsonSerializable()
class TransactionsResponse {
  TransactionsResponse([
    this.id,
    this.receiverAccountId,
    this.senderAccountId,
    this.amount,
    this.transactionDate,
    this.currency,
    this.transactionType,
  ]);

  factory TransactionsResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionsResponseToJson(this);


  @JsonKey(defaultValue: '')
  final String? id;

  @JsonKey(defaultValue: '')
  final String? receiverAccountId;

  @JsonKey(defaultValue: '')
  final String? senderAccountId;

  @JsonKey(defaultValue: '')
  final String? amount;

  @JsonKey(defaultValue: '')
  final String? transactionDate;

  @JsonKey(defaultValue: '')
  final String? currency;

  @JsonKey(defaultValue: '')
  final String? transactionType;

}