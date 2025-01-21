import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya_tech_exam/domains/datasource/models/generic_response.dart';
import 'package:maya_tech_exam/domains/datasource/models/sendmoney/send_money_request.dart';
import 'package:maya_tech_exam/domains/datasource/models/sendmoney/send_money_response.dart';
import 'package:maya_tech_exam/domains/repositories/user_repository.dart';



part 'send_money_event.dart';
part 'send_money_state.dart';

class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState> {
  final UserRepository _userRepository;

  SendMoneyBloc(this._userRepository) : super(const SendMoneyState.initial()) {
    on<SendMoneyRequired>((event, emit) async {
      emit(state.asLoading());
      GenericResponse<SendMoneyResponse>? response =
          await _userRepository.sendMoney(request: event.body);
      if (response != null) {
        if (response.status == 200) {
          emit(state.asSuccess(response.data));
        } else {
          emit(state.asFailure(Exception(response.errors?.toList())));
        }
      } else {
        emit(state.asFailure(Exception("API Issue")));
      }
    });
  }
}
