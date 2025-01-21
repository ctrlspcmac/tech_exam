part of 'user_details_bloc.dart';

abstract class UserDetailsEvent {
  const UserDetailsEvent();
}

class GetUserDetails extends UserDetailsEvent {
  String body = "";

  GetUserDetails({required this.body});
}

class UpdateBalance extends UserDetailsEvent {
  UserDetails body;

  UpdateBalance({required this.body});
}
