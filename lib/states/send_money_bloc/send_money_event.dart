part of 'send_money_bloc.dart';

abstract class SendMoneyEvent {
  const SendMoneyEvent();
}

class SendMoneyRequired extends SendMoneyEvent {
  SendReceiveMoneyRequest body;

  SendMoneyRequired({required this.body});
}
