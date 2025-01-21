import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya_tech_exam/domains/datasource/models/generic_response.dart';
import 'package:maya_tech_exam/domains/datasource/models/login/usercred_data.dart';
import 'package:maya_tech_exam/domains/datasource/models/login/userinfo_data.dart';
import 'package:maya_tech_exam/domains/repositories/user_repository.dart';



part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;

  SignInBloc(this._userRepository) : super(const SignInState.initial()) {
    on<SignInRequired>((event, emit) async {
      emit(state.asLoading());
      GenericResponse<UserInfoModel>? response =
          await _userRepository.signIn(request: event.body);
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
