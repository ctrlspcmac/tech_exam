import 'package:json_annotation/json_annotation.dart';

part 'send_money_request.g.dart';

@JsonSerializable()
class SendReceiveMoneyRequest {
  SendReceiveMoneyRequest({
    required this.receiverAccountId,
    required this.senderAccountId,
    required this.amount,
    required this.transactionDate,
    required this.currency,
    required this.transactionType,
  });

  factory SendReceiveMoneyRequest.fromJson(Map<String, dynamic> json) =>
      _$SendReceiveMoneyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendReceiveMoneyRequestToJson(this);


  @JsonKey(defaultValue: '')
  final String? receiverAccountId;

  @JsonKey(defaultValue: '')
  final String? senderAccountId;

  @JsonKey(defaultValue: '')
  final String? amount;

  @JsonKey(defaultValue: '')
  final String? transactionDate;

  @JsonKey(defaultValue: '')
  final String? transactionType;

  @JsonKey(defaultValue: '')
  final String? currency;

}
