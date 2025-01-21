import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya_tech_exam/domains/datasource/models/generic_response.dart';
import 'package:maya_tech_exam/domains/datasource/models/user_details/user_details.dart';
import 'package:maya_tech_exam/domains/repositories/user_repository.dart';



part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final UserRepository _userRepository;

  UserDetailsBloc(this._userRepository) : super(const UserDetailsState.initial()) {
    on<GetUserDetails>((event, emit) async {
      emit(state.asLoading());

      GenericResponse<UserDetails>? response =
          await _userRepository.getUserDetails(request: event.body);
      if (response != null) {
        if (response.status == 200) {
          emit(state.asSuccess(response.data));
        } else {
          emit(state.asFailure(Exception(response.errors)));
        }
      } else {
        emit(state.asFailure(Exception("API Issue")));
      }
    });

    on<UpdateBalance>((event, emit) async {
      emit(state.asLoading());
      GenericResponse<UserDetails>? response =
          await _userRepository.updateBalance(request: event.body);
      if (response != null) {
        if (response.status == 200) {
          emit(state.asSuccess(response.data));
        } else {
          emit(state.asFailure(Exception(response.errors)));
        }
      } else {
        emit(state.asFailure(Exception("API Issue")));
      }
    });
  }


}
