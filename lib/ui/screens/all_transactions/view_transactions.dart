import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya_tech_exam/configs/colors.dart';
import 'package:maya_tech_exam/configs/images.dart';
import 'package:maya_tech_exam/states/transactions/transactions_bloc.dart';
import 'package:maya_tech_exam/ui/screens/dashboard/widgets/appbar.dart';
import 'package:maya_tech_exam/utils/alert_dialog_utils.dart';
import 'package:maya_tech_exam/utils/extensions/string_regex_extensions.dart';
import 'package:maya_tech_exam/utils/utils.dart';

class ViewAllTransactionsScreen extends StatefulWidget {
  final Map<String, dynamic>? arguments;
  const ViewAllTransactionsScreen({super.key, this.arguments});

  @override
  State<StatefulWidget> createState() => _ViewAllTransactionsState();
}

class _ViewAllTransactionsState extends State<ViewAllTransactionsScreen> {

  late  final String accountIdValue ;

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
    final arguments = widget.arguments;
    if(arguments != null){
      accountIdValue = arguments['accountId'] ?? '0';
      LoggerUtil.info("PASSED ACCOUNT ID : $accountIdValue");
    }
  }

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      context
          .read<TransactionsBloc>()
          .add(GetTransactions(body: accountIdValue));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionsBloc, TransactionsState>(
      listener: (context, state) {
        if (state.status == TransactionsStatus.loading) {
          LoggerUtil.info("Loading transactions...");
        } else if (state.status == TransactionsStatus.failure) {
          LoggerUtil.info("Error: ${state.error.toString()}");
        }
      },
      child: Scaffold(
        appBar: AppBarCustom(
          showBackButton: true,
          accountIdValue: accountIdValue,
        ),
        body: Center(
          child: BlocBuilder<TransactionsBloc, TransactionsState>(
            builder: (context, state) {
              if (state.status == TransactionsStatus.loading) {
                return const Text('Fetching Data');
              } else if (state.status == TransactionsStatus.success) {
                final transactions = state.body;
                if (transactions?.isEmpty == true) {
                  return const Text('No Data');
                }
                return Padding(padding: EdgeInsets.only(left: 32,right: 32),child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0).safePadding,
                      // Optional: Adjust padding for the label
                      child: Text(
                        'Transactions',
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lineColor),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                          itemCount: transactions?.length ?? 0,
                          itemBuilder: (context, index) {
                            final transaction = transactions?[index];
                            return Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  // Optional: Margin to separate tiles
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // Set background color
                                    borderRadius: BorderRadius.circular(10),
                                    // Optional: Rounded corners
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.2),
                                        // Color of the shadow
                                        blurRadius: 8.0,
                                        // Softness of the shadow
                                        offset: Offset(
                                            0, 4), // Horizontal and vertical offset
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    leading: Image(image: AppImages.icWallet),
                                    title: Text(transaction?.receiverAccountId ?? "",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: AppColors.iconColor)),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${transaction?.amount ?? ""} ${transaction?.currency ?? ""}",
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.iconColor)),
                                        Text('${transaction?.transactionDate}',
                                            style: TextStyle(
                                                fontSize: 8.0,
                                                color: AppColors.lineColor)),
                                      ],
                                    ),
                                    trailing: Transform.rotate(
                                      angle: -45 * 3.1416 / 180,
                                      child: transaction?.transactionType == "SEND"
                                          ? Icon(
                                        Icons.arrow_forward,
                                        color: AppColors.colorSecondary,
                                      )
                                          : Icon(
                                        Icons.arrow_back,
                                        color: AppColors.blue,
                                      ),
                                    ),
                                    onTap: () {
                                      AlertDialogUtils.showAlertDialog(
                                          context: context,
                                          contentText: 'Tapped on transaction: ${transaction?.id}',
                                          buttonText: 'Ok',
                                          onButtonPressed: () {
                                            AlertDialogUtils.hideAlertDialog(context: context);
                                          });
                                      LoggerUtil.info(
                                          'Tapped on transaction: ${transaction?.id}');
                                    },
                                  ),
                                ),
                                // Add a SizedBox to provide spacing of 12.0 after each item
                                SizedBox(height: 12.0),
                                // 12 pixels of vertical space between items
                              ],
                            );
                          },
                        ))
                  ],
                ),);
              } else if (state.status == TransactionsStatus.failure) {
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
