import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya_tech_exam/configs/colors.dart';
import 'package:maya_tech_exam/configs/images.dart';
import 'package:maya_tech_exam/domains/datasource/models/user_details/user_details.dart';
import 'package:maya_tech_exam/routes.dart';
import 'package:maya_tech_exam/states/user_details/user_details_bloc.dart';
import 'package:maya_tech_exam/utils/extensions/string_regex_extensions.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final String accountIdValue;

  @override
  final Size preferredSize;

  AppBarCustom({super.key, this.showBackButton = false,this.accountIdValue = ""})
      : preferredSize = Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        height: 100.0,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(22).safePadding,
              child: showBackButton
                  ? Center(
                      child: GestureDetector(
                      onTap: () {
                        AppNavigator.pop();
                      },
                      child: Container(
                        width: 60,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.all(Radius.circular(22)),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            size: 22,
                            color: AppColors.colorSecondary,
                          ),
                        ),
                      ),
                    ))
                  : Image(
                      image: AppImages.profilePlaceHolderImage,
                      fit: BoxFit.cover,
                      alignment: Alignment.centerLeft,
                    ),
            ),
            Spacer(),
            const Icon(Icons.notifications_active_outlined,
                color: Colors.black),
            Padding(padding: const EdgeInsets.all(8.0).safePadding),
            GestureDetector(
              onTap: () {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  var request = UserDetails(
                      accountIdValue, "", "10000.0");
                  context
                      .read<UserDetailsBloc>()
                      .add(UpdateBalance(body: request));
                });
                AppNavigator.replaceWith(
                    Routes.loginPage);
              },
              child: const Icon(Icons.logout_outlined, color: Colors.black),
            ),
            Padding(padding: const EdgeInsets.all(8.0).safePadding),
          ],
        ),
      ),
    );
  }
}
