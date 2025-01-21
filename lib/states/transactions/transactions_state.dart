part of 'transactions_bloc.dart';

enum TransactionsStatus {
  initial,
  loading,
  success,
  failure,
}

class TransactionsState {
  TransactionsState({
    this.status = TransactionsStatus.initial,
    this.body,
    this.error,
  });

  final TransactionsStatus status;
  final List<TransactionsResponse>? body;
  final Exception? error;

  const TransactionsState._({
    this.status = TransactionsStatus.initial,
    this.body,
    this.error,
  });

  const TransactionsState.initial() : this._();

  TransactionsState asLoading() {
    return copyWith(
      status: TransactionsStatus.loading,
    );
  }

  TransactionsState asSuccess(List<TransactionsResponse>? data) {
    return copyWith(
      status: TransactionsStatus.success,
      data: data,
    );
  }

  TransactionsState asFailure(Exception e) {
    return copyWith(
      status: TransactionsStatus.failure,
      error: e,
    );
  }

  TransactionsState copyWith({
    TransactionsStatus? status,
    List<TransactionsResponse>? data,
    Exception? error,
  }) {
    return TransactionsState._(
      status: status ?? this.status,
      body: data ?? body,
      error: error ?? this.error,
    );
  }
}
