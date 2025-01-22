import 'dart:async';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maya_tech_exam/configs/colors.dart';
import 'package:maya_tech_exam/configs/constants.dart';
import 'package:maya_tech_exam/domains/datasource/models/sendmoney/send_money_request.dart';
import 'package:maya_tech_exam/domains/datasource/models/user_details/user_details.dart';
import 'package:maya_tech_exam/routes.dart';
import 'package:maya_tech_exam/states/send_money_bloc/send_money_bloc.dart';
import 'package:maya_tech_exam/states/user_details/user_details_bloc.dart';
import 'package:maya_tech_exam/ui/screens/dashboard/widgets/appbar.dart';
import 'package:maya_tech_exam/utils/alert_dialog_utils.dart';
import 'package:maya_tech_exam/utils/bottom_sheet.dart';
import 'package:maya_tech_exam/utils/extensions/string_regex_extensions.dart';
import 'package:maya_tech_exam/utils/utils.dart';

class SendMoneyScreen extends StatefulWidget {
  final Map<String, dynamic>? arguments;

  const SendMoneyScreen({super.key, this.arguments});

  @override
  State<StatefulWidget> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  bool _isBalanceVisible = true;
  String _accountNo = "1";
  String _amount = "1";

  late final String accountIdValue;
  String _balance = "0";

  bool _isEnabled = false;

  void _updateAccountNo() {
    setState(() {
      _accountNo = _accountNumberController.text;
      _amount = _amountController.text;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = widget.arguments;
    if (arguments != null) {
      accountIdValue = arguments['accountId'] ?? '0';
      _balance = arguments['balance'] ?? '0';
      LoggerUtil.info("PASSED ACCOUNT ID : $accountIdValue");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(
          showBackButton: true,
          accountIdValue: accountIdValue,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: BlocListener<SendMoneyBloc, SendMoneyState>(
                listener: (BuildContext context, SendMoneyState state) {
                  if (state.status == SendMoneyStatus.loading) {
                    //show loading
                    AlertDialogUtils.showLoadingAlertDialog(context: context);
                  } else if (state.status == SendMoneyStatus.success) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      var request = UserDetails(
                          accountIdValue, "", validateTransaction().toString());
                      LoggerUtil.info(request.balance.toString());

                      context
                          .read<UserDetailsBloc>()
                          .add(UpdateBalance(body: request));

                      setState(() {
                        final formatter = NumberFormat('#,##0.00', 'en_US');
                        var tempBal = formatter.format(
                            double.parse(request.balance.toString()));
                        _balance = "$tempBal PHP";
                      });
                      //hide loading
                      AlertDialogUtils.hideAlertDialog(context: context);
                      kIsWeb == false
                          ? openBottomSheet("Success")
                          : AlertDialogUtils.showAlertDialog(
                              context: context,
                              contentText: 'Success',
                              buttonText: 'Ok',
                              onButtonPressed: () {
                                AlertDialogUtils.hideAlertDialog(
                                    context: context);
                              });
                    });
                  } else if (state.status == SendMoneyStatus.failure) {
                    AlertDialogUtils.hideAlertDialog(context: context);
                    //show error msg
                    kIsWeb == false
                        ? openBottomSheet(state.error.toString())
                        : AlertDialogUtils.showAlertDialog(
                            context: context,
                            contentText: 'Failed',
                            buttonText: 'Ok',
                            onButtonPressed: () {
                              AlertDialogUtils.hideAlertDialog(
                                  context: context);
                            });
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Available Balance",
                        style: TextStyle(
                            fontSize: 18, color: AppColors.titleColor)),
                    SizedBox(width: 12, height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _isBalanceVisible
                              ? _balance.replaceAll(RegExp(r'.'), '*')
                              : _balance,
                          style: TextStyle(
                              fontSize: 35,
                              color: AppColors.colorSecondary,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(width: 12, height: 12),
                        IconButton(
                          icon: Icon(
                            _isBalanceVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.colorSecondary,
                          ),
                          onPressed: () {
                            setState(() {
                              _isBalanceVisible = !_isBalanceVisible;
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(width: 12, height: 12),
                    Text(
                        "Please, enter the receiver’s bank account number in below field.",
                        style: TextStyle(
                            fontSize: 14, color: AppColors.titleColor)),
                    SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                Color(0xFF2FF29E).withValues(alpha: 0.15),
                                Color(0xFF2FF29E).withValues(alpha: 0.01),
                              ],
                              radius: 0.6,
                              center: Alignment.center,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, right: 0, top: 15, bottom: 0),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 24, right: 24),
                                    child: TextFormField(
                                      controller: _accountNumberController,
                                      onChanged: (value) => {validateInput()},
                                      decoration: InputDecoration(
                                        labelText: AppStrings.accountNumber,
                                        labelStyle: TextStyle(
                                            color: AppColors.colorSecondary,
                                            fontSize: 16),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        errorStyle:
                                            const TextStyle(color: Colors.red),
                                        errorMaxLines: 2,
                                        fillColor: Colors.transparent,
                                        filled: true,
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.colorSecondary,
                                              width: 1),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.colorSecondary,
                                              width: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 24, top: 15, bottom: 0),
                                  child: TextFormField(
                                    controller: _amountController,
                                    onChanged: (value) => {validateInput()},
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      CurrencyTextInputFormatter.currency(
                                        locale: 'fil_PH',
                                        decimalDigits: 2,
                                        symbol: 'PHP ',
                                      ),
                                    ],
                                    decoration: InputDecoration(
                                      labelText: AppStrings.enterAmount,
                                      labelStyle: TextStyle(
                                          color: AppColors.colorSecondary,
                                          fontSize: 16),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      errorStyle:
                                          const TextStyle(color: Colors.red),
                                      errorMaxLines: 2,
                                      fillColor: Colors.transparent,
                                      filled: true,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.colorSecondary,
                                            width: 1),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.colorSecondary,
                                            width: 1),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: _isEnabled
                                          ? AppColors.colorSecondary
                                          : AppColors.titleColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TextButton(
                                      key: const Key('SendMoney'),
                                      onPressed: _isEnabled
                                          ? () {
                                              _updateAccountNo();
                                              DateTime now = DateTime.now();
                                              var dateNow = DateFormat(
                                                      'yyyy-MM-dd HH:mm:ss')
                                                  .format(now);
                                              scheduleMicrotask(() {
                                                context
                                                    .read<SendMoneyBloc>()
                                                    .add(SendMoneyRequired(
                                                        //**to update **//
                                                        body: SendReceiveMoneyRequest(
                                                            receiverAccountId:
                                                                _accountNo,
                                                            senderAccountId:
                                                                accountIdValue,
                                                            amount: _amount,
                                                            transactionDate:
                                                                dateNow,
                                                            currency: "PHP",
                                                            transactionType:
                                                                "SEND")));
                                              });
                                            }
                                          : null,
                                      child: Text(
                                        AppStrings.sendMoney,
                                        style: TextStyle(
                                            color: _isEnabled
                                                ? AppColors.black
                                                : AppColors.lineColor,
                                            fontSize: 22),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ));
  }

  void openBottomSheet(String status) {
    BottomSheetUtils.showCustomBottomSheet(
        context: context,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  status,
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    LoggerUtil.info(
                        "PASSED ACCOUNT ID SEND MONEY : $accountIdValue");
                    AppNavigator.replaceWith(
                        Routes.dashboard, {'accountId': accountIdValue});
                  },
                  icon: Icon(Icons.close_outlined),
                ),
              ],
            ),
          ],
        ));
  }

  void validateInput() {
    setState(() {
      if (_accountNumberController.text.isEmpty ||
          _amountController.text.isEmpty) {
        _isEnabled = false;
      } else {
        var holdAmnt = _amountController.text.toDoubleInFront();
        var holdBal = _balance.toString().toDouble();
        _isEnabled = !(holdBal == 0.0 || holdAmnt > holdBal);
      }
    });
  }

  double validateTransaction() {
    var holdAmnt = _amountController.text.toDoubleInFront();
    var holdBal = _balance.toString().toDouble();
    var endBalance = holdBal - holdAmnt;
    return endBalance;
  }
}
