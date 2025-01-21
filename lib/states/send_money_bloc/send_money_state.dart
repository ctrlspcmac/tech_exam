part of 'send_money_bloc.dart';

enum SendMoneyStatus {
  initial,
  loading,
  success,
  failure,
}

class SendMoneyState {
  SendMoneyState({
    this.status = SendMoneyStatus.initial,
    this.body,
    this.error,
  });

  final SendMoneyStatus status;
  final SendMoneyResponse? body;
  final Exception? error;

  const SendMoneyState._({
    this.status = SendMoneyStatus.initial,
    this.body,
    this.error,
  });

  const SendMoneyState.initial() : this._();

  SendMoneyState asLoading() {
    return copyWith(
      status: SendMoneyStatus.loading,
    );
  }

  SendMoneyState asSuccess(SendMoneyResponse? data) {
    return copyWith(
      status: SendMoneyStatus.success,
      data: data,
    );
  }

  SendMoneyState asFailure(Exception e) {
    return copyWith(
      status: SendMoneyStatus.failure,
      error: e,
    );
  }

  SendMoneyState copyWith({
    SendMoneyStatus? status,
    SendMoneyResponse? data,
    Exception? error,
  }) {
    return SendMoneyState._(
      status: status ?? this.status,
      body: data ?? body,
      error: error ?? this.error,
    );
  }
}
