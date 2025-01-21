import 'package:flutter/material.dart';
import 'package:maya_tech_exam/ui/screens/all_transactions/view_transactions.dart';
import 'package:maya_tech_exam/ui/screens/dashboard/dashboard.dart';
import 'package:maya_tech_exam/ui/screens/login/login_page.dart';
import 'package:maya_tech_exam/ui/screens/sendmoney/sendmoney.dart';
import 'package:maya_tech_exam/utils/FadeRoute/fade_page_route.dart';

enum Routes {
  splash,
  dashboard,
  loginPage,
  sendMoneyPage,
  transactionsPage,
}

class _Paths {
  static const String splash = '/';
  static const String dashboard = '/dashboard';
  static const String loginPage = '/login';
  static const String sendMoneyPage = '/sendMoneyPage';
  static const String transactionsPage = '/transactionsPage';

  static const Map<Routes, String> _pathMap = {
    Routes.dashboard: _Paths.dashboard,
    Routes.loginPage: _Paths.loginPage,
    Routes.sendMoneyPage: _Paths.sendMoneyPage,
    Routes.transactionsPage: _Paths.transactionsPage,
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.dashboard:
        {
          final arguments = settings.arguments as Map<String, dynamic>?;
          return FadeRoute(
              page: DashboardScreen(
            arguments: arguments,
          ));
        }

      case _Paths.sendMoneyPage:
        {
          final arguments = settings.arguments as Map<String, dynamic>?;
          return FadeRoute(
              page: SendMoneyScreen(
            arguments: arguments,
          ));
        }

      case _Paths.transactionsPage:
        {
          final arguments = settings.arguments as Map<String, dynamic>?;
          return FadeRoute(
              page: ViewAllTransactionsScreen(
                arguments: arguments,
              ));
        }

      case _Paths.loginPage:
      default:
        return FadeRoute(page: const LoginPage());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void popToFirst() => state?.popUntil((route) => route.isFirst);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
