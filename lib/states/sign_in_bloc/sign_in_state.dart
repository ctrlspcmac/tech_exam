part of 'sign_in_bloc.dart';

enum SignInStatus {
  initial,
  loading,
  success,
  failure,
}

class SignInState {
  SignInState({
    this.status = SignInStatus.initial,
    this.body,
    this.error,
  });

  final SignInStatus status;
  final UserInfoModel? body;
  final Exception? error;

  const SignInState._({
    this.status = SignInStatus.initial,
    this.body,
    this.error,
  });

  const SignInState.initial() : this._();

  SignInState asLoading() {
    return copyWith(
      status: SignInStatus.loading,
    );
  }

  SignInState asSuccess(UserInfoModel? data) {
    return copyWith(
      status: SignInStatus.success,
      data: data,
    );
  }

  SignInState asFailure(Exception e) {
    return copyWith(
      status: SignInStatus.failure,
      error: e,
    );
  }

  SignInState copyWith({
    SignInStatus? status,
    UserInfoModel? data,
    Exception? error,
  }) {
    return SignInState._(
      status: status ?? this.status,
      body: data ?? body,
      error: error ?? this.error,
    );
  }
}
