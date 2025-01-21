import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya_tech_exam/domains/datasource/models/generic_response.dart';
import 'package:maya_tech_exam/domains/datasource/models/transactions/transactions_response.dart';
import 'package:maya_tech_exam/domains/repositories/user_repository.dart';


part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final UserRepository _userRepository;

  TransactionsBloc(this._userRepository) : super(const TransactionsState.initial()) {
    on<GetTransactions>((event, emit) async {
      emit(state.asLoading());
      GenericResponse<List<TransactionsResponse>?>? response =
          await _userRepository.getAllTransactions(request: event.body);
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
