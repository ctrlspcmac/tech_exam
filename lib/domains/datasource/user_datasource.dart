import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:maya_tech_exam/domains/datasource/models/sendmoney/send_money_request.dart';
import 'package:maya_tech_exam/domains/datasource/models/sendmoney/send_money_response.dart';
import 'package:maya_tech_exam/domains/datasource/models/transactions/transactions_response.dart';
import 'package:maya_tech_exam/domains/datasource/models/user_details/user_details.dart';
import 'package:maya_tech_exam/domains/networks/network.dart';
import 'package:maya_tech_exam/utils/utils.dart';

import 'models/generic_response.dart';
import 'models/login/usercred_data.dart';
import 'models/login/userinfo_data.dart';

class UserDataSource {
  UserDataSource(this.networkManager);

  static const String baseUrlApp = 'http://10.0.2.2:3000/';
  static const String baseUrlWeb = 'http://localhost:3000/';

  static const String logInApiUrl = 'users/';
  static const String sendReceiveMoneyApiUrl = 'TransactionHistory';
  static const String transactionsApiUrl = 'TransactionHistory';
  static const String userDetailsApiUrl = 'accounts/';
  static const String updateBalanceApiUrl = 'accounts/';

  final NetworkManager networkManager;

  Future<GenericResponse<UserInfoModel>> login(
      UserCredentialsModel body) async {
    try {
      var baseUrl = kIsWeb ? baseUrlWeb : baseUrlApp;

      LoggerUtil.info(baseUrl + logInApiUrl);
      final response = await networkManager.request(
          RequestMethod.get, baseUrl + logInApiUrl);

      List<dynamic> parsedList = jsonDecode(jsonEncode(response.data));
      var listParsed = parsedList.map((e) => UserInfoModel.fromJson(e));

      var userModel = listParsed.firstWhere(
        (item) => item.userName?.toLowerCase() == body.userName?.toLowerCase(),
        orElse: () => UserInfoModel(),
      );

      if (userModel.userName != body.userName ||
          userModel.password != body.password) {
        return GenericResponse(304, "Username not found",
            ["Invalid Credentials"], UserInfoModel());
      }

      return GenericResponse(200, "Success", [], userModel);
    } on DioError catch (e) {
      LoggerUtil.error(e.message.toString());
    }
    return GenericResponse(404, "Logged in failed", [], UserInfoModel());
  }

  Future<GenericResponse<SendMoneyResponse>> sendMoney(
      SendReceiveMoneyRequest body) async {
    try {
      var baseUrl = kIsWeb ? baseUrlWeb : baseUrlApp;
      final response = await networkManager.request(
          RequestMethod.post, baseUrl + sendReceiveMoneyApiUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          data: body.toJson());

      LoggerUtil.info("body data :${body.toJson()}");

      var holder =
          SendMoneyResponse.fromJson(jsonDecode(jsonEncode(response.data)));

      LoggerUtil.info(" response data :${holder.id}");

      return holder.id != null
          ? GenericResponse(200, "Success", [],
              SendMoneyResponse(holder.id, holder.transactionDate))
          : GenericResponse(
              300, "Failed", ["Invalid Transaction"], SendMoneyResponse());
    } on DioError catch (e) {
      LoggerUtil.error(e.message.toString());
    }
    return GenericResponse(404, "Sending failed", [], SendMoneyResponse());
  }

  Future<GenericResponse<List<TransactionsResponse>>> allTransactions(
      String body) async {
    try {
      LoggerUtil.info(" ======== GET ALL TRANSACTIONS ========");
      var baseUrl = kIsWeb ? baseUrlWeb : baseUrlApp;
      final response = await networkManager.request(
          RequestMethod.get, baseUrl + transactionsApiUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      List<dynamic> parsedList = jsonDecode(jsonEncode(response.data));

      var listParsed =
          parsedList.map((e) => TransactionsResponse.fromJson(e)).toList();
      var filtered =
          listParsed.where((e) => e.senderAccountId == body).toList();
      if (filtered.isNotEmpty) {
        DateTime now = DateTime.now();
        var dateNow = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
        filtered.sort((a, b) => DateTime.parse(b.transactionDate ?? dateNow)
            .compareTo(DateTime.parse(a.transactionDate ?? dateNow)));

        return GenericResponse(200, "Success", [], filtered);
      } else {
        return GenericResponse(200, "Success", ["Empty Data"], filtered);
      }
    } on DioError catch (e) {
      LoggerUtil.error(e.stackTrace.toString());
    }
    return GenericResponse(404, "Fetch failed", [], []);
  }

  Future<GenericResponse<UserDetails>> getUserDetails(String body) async {
    try {
      var baseUrl = kIsWeb ? baseUrlWeb : baseUrlApp;
      LoggerUtil.info(baseUrl + userDetailsApiUrl);

      final response = await networkManager.request(
          RequestMethod.get, baseUrl + userDetailsApiUrl + body);

      LoggerUtil.info(
          "getUserDetails : ${jsonDecode(jsonEncode(response.data))}");

      var responseData =
          UserDetails.fromJson(jsonDecode(jsonEncode(response.data)));
      return responseData.accountName?.isNotEmpty == true
          ? GenericResponse(200, "Success", [], responseData)
          : GenericResponse(
              400, "failed", ["Invalid Account Id"], UserDetails());
    } on DioError catch (e) {
      LoggerUtil.error(e.message.toString());
    }
    return GenericResponse(404, "Logged in failed", [], UserDetails());
  }

  Future<GenericResponse<UserDetails>> updateBalance(UserDetails body) async {
    try {
      var baseUrl = kIsWeb ? baseUrlWeb : baseUrlApp;
      LoggerUtil.info(baseUrl + updateBalanceApiUrl);
      var tempId = body.id ?? "";
      LoggerUtil.info(tempId);
      final Map<String, dynamic> data = {
        'balance': body.balance
      };
      LoggerUtil.info(data.toString());
      LoggerUtil.info(baseUrl + updateBalanceApiUrl + tempId);

      final response = await networkManager.request(
          RequestMethod.patch, baseUrl + updateBalanceApiUrl + tempId,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          data: jsonEncode(data));

      LoggerUtil.info(
          "updateBalance : ${jsonDecode(jsonEncode(response.data))}");

      var responseData =
          UserDetails.fromJson(jsonDecode(jsonEncode(response.data)));

      return responseData.accountName?.isNotEmpty == true
          ? GenericResponse(200, "Success", [], responseData)
          : GenericResponse(
              400, "failed", ["Invalid Account Id"], UserDetails());
    } on DioError catch (e) {
      LoggerUtil.error(e.message.toString());
    }
    return GenericResponse(404, "Logged in failed", [], UserDetails());
  }
}
