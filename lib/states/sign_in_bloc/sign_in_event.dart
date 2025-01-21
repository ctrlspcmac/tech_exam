part of 'sign_in_bloc.dart';

abstract class SignInEvent {
  const SignInEvent();
}

class SignInRequired extends SignInEvent {
  UserCredentialsModel body;

  SignInRequired({required this.body});
}
