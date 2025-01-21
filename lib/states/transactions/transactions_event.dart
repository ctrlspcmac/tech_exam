part of 'transactions_bloc.dart';

abstract class TransactionsEvent {
  const TransactionsEvent();
}

class GetTransactions extends TransactionsEvent {
  String body;
  GetTransactions({required this.body});
}
