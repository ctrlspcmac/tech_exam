import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maya_tech_exam/configs/colors.dart';
import 'package:maya_tech_exam/configs/constants.dart';
import 'package:maya_tech_exam/configs/images.dart';
import 'package:maya_tech_exam/routes.dart';
import 'package:maya_tech_exam/states/user_details/user_details_bloc.dart';
import 'package:maya_tech_exam/ui/screens/dashboard/widgets/appbar.dart';
import 'package:maya_tech_exam/ui/screens/dashboard/widgets/big_button.dart';
import 'package:maya_tech_exam/utils/utils.dart';

class DashboardScreen extends StatefulWidget {
  final Map<String, dynamic>? arguments;

  const DashboardScreen({super.key, this.arguments});

  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _isBalanceVisible = true;
  String _balance = "0.00 PHP";

  late final String accountIdValue;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = widget.arguments;
    if (arguments != null) {
      accountIdValue = arguments['accountId'] ?? '0';
      LoggerUtil.info("PASSED ACCOUNT ID : $accountIdValue");
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
    scheduleMicrotask(() {
      context.read<UserDetailsBloc>().add(GetUserDetails(body: accountIdValue));
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserDetailsBloc, UserDetailsState>(
      listener: (context, state) {
        if (state.status == UserDetailsStatus.loading) {
          LoggerUtil.info("Loading transactions...");
        } else if (state.status == UserDetailsStatus.failure) {
          LoggerUtil.info("Error: ${state.error.toString()}");
        }
      },
      child: Scaffold(
        appBar: AppBarCustom(accountIdValue: accountIdValue,),
        body: Center(
          child: BlocBuilder<UserDetailsBloc, UserDetailsState>(
            builder: (context, state) {
              if (state.status == UserDetailsStatus.loading) {
                return const Text('Fetching Data');
              } else if (state.status == UserDetailsStatus.success) {
                final userDetails = state.body?.accountName;
                final formatter = NumberFormat('#,##0.00', 'en_US');
                var tempBal = formatter.format(double.parse(state.body?.balance ?? "0.0"));
                _balance = "$tempBal PHP";
                if (userDetails?.isEmpty == true) {
                  return const Text('No Data');
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        width: double.infinity,
                        height: 140.0,
                        decoration: BoxDecoration(
                          color: AppColors.black85,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AppImages.icWallet,
                                    width: 24,
                                    height: 24,
                                  ),
                                  Padding(padding: const EdgeInsets.all(4.0)),
                                  Text(
                                    _isBalanceVisible
                                        ? _balance.replaceAll(RegExp(r'.'), '*')
                                        : _balance,
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  Spacer(),
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
                              SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userDetails ?? "",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    Text(
                                      "Technical Exam",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.lineColor),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(12, 0, 12, 12),child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BigButton(
                          text: AppStrings.transactionsView,
                          subTitle: "",
                          icon: Icons.view_list,
                          color: AppColors.colorSecondary,
                          isRotate: false,
                          onPressed: () {
                            AppNavigator.push(Routes.transactionsPage,
                                {'accountId': accountIdValue});
                            LoggerUtil.info('Transactions button pressed');
                          },
                        ),
                        BigButton(
                          text: AppStrings.sendMoney,
                          subTitle: "",
                          icon: Icons.arrow_forward,
                          color: AppColors.iconButtonColor,
                          isRotate: true,
                          onPressed: () {
                            AppNavigator.push(Routes.sendMoneyPage, {
                              'accountId': accountIdValue,
                              'balance': _balance
                            });
                            LoggerUtil.info('Send Money button pressed');
                          },
                        ),
                      ],
                    ),)
                  ],
                );
              } else if (state.status == UserDetailsStatus.failure) {
                return Text('Error: ${state.error.toString()}');
              }
              return const Text('No Data');
            },
          ),
        ),
      ),
    );
  }
}
