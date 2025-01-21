import 'package:json_annotation/json_annotation.dart';

part 'send_money_response.g.dart';

@JsonSerializable()
class SendMoneyResponse {
  SendMoneyResponse([
    this.id,
    this.transactionDate,
  ]);

  factory SendMoneyResponse.fromJson(Map<String, dynamic> json) =>
      _$SendMoneyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendMoneyResponseToJson(this);

  @JsonKey(defaultValue: '')
  final String? id;

  @JsonKey(defaultValue: '')
  final String? transactionDate;

}
