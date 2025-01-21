import 'package:maya_tech_exam/domains/datasource/models/generic_response.dart';
import 'package:maya_tech_exam/domains/datasource/models/login/usercred_data.dart';
import 'package:maya_tech_exam/domains/datasource/models/login/userinfo_data.dart';
import 'package:maya_tech_exam/domains/datasource/models/sendmoney/send_money_request.dart';
import 'package:maya_tech_exam/domains/datasource/models/sendmoney/send_money_response.dart';
import 'package:maya_tech_exam/domains/datasource/models/transactions/transactions_response.dart';
import 'package:maya_tech_exam/domains/datasource/models/user_details/user_details.dart';
import 'package:maya_tech_exam/domains/datasource/user_datasource.dart';

abstract class UserRepository {
  Future<GenericResponse<UserInfoModel>?>? signIn(
      {required UserCredentialsModel request});

  Future<GenericResponse<SendMoneyResponse>?>? sendMoney(
      {required SendReceiveMoneyRequest request});


  Future<GenericResponse<UserDetails>?>? getUserDetails(
      {required String request});

  Future<GenericResponse<List<TransactionsResponse>>?>? getAllTransactions(
      {required String request});

  Future<GenericResponse<UserDetails>>? updateBalance(
      {required UserDetails request});


  Future<void> logOut();
}

class UserDefaultRepository extends UserRepository {
  UserDefaultRepository({required this.dataSource});

  final UserDataSource dataSource;

  @override
  Future<GenericResponse<UserInfoModel>?>? signIn(
      {required UserCredentialsModel request}) async {
    final response = await dataSource.login(request);
    return response;
  }

  @override
  Future<GenericResponse<List<TransactionsResponse>>?>? getAllTransactions(
      {required String request}) async {
    final response = await dataSource.allTransactions(request);
    return response;
  }

  @override
  Future<void> logOut() async {
    //logout
  }

  @override
  Future<GenericResponse<SendMoneyResponse>?>? sendMoney(
      {required SendReceiveMoneyRequest request}) async {
    final response = await dataSource.sendMoney(request);
    return response;
  }

  @override
  Future<GenericResponse<UserDetails>?>? getUserDetails(
      {required String request}) async {
    final response = await dataSource.getUserDetails(request);
    return response;
  }

  @override
  Future<GenericResponse<UserDetails>>? updateBalance({required UserDetails request}) async {
    final response = await dataSource.updateBalance(request);
    return response;
  }
}
