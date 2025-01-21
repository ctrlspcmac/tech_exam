part of 'user_details_bloc.dart';

enum UserDetailsStatus {
  initial,
  loading,
  success,
  failure,
}

class UserDetailsState {
  UserDetailsState({
    this.status = UserDetailsStatus.initial,
    this.body,
    this.error,
  });

  final UserDetailsStatus status;
  final UserDetails? body;
  final Exception? error;

  const UserDetailsState._({
    this.status = UserDetailsStatus.initial,
    this.body,
    this.error,
  });

  const UserDetailsState.initial() : this._();

  UserDetailsState asLoading() {
    return copyWith(
      status: UserDetailsStatus.loading,
    );
  }

  UserDetailsState asSuccess(UserDetails? data) {
    return copyWith(
      status: UserDetailsStatus.success,
      data: data,
    );
  }

  UserDetailsState asFailure(Exception e) {
    return copyWith(
      status: UserDetailsStatus.failure,
      error: e,
    );
  }

  UserDetailsState copyWith({
    UserDetailsStatus? status,
    UserDetails? data,
    Exception? error,
  }) {
    return UserDetailsState._(
      status: status ?? this.status,
      body: data ?? body,
      error: error ?? this.error,
    );
  }
}
