import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:maya_tech_exam/routes.dart';
import 'package:maya_tech_exam/theme/theme_cubit.dart';

import 'configs/theme.dart';


class MainScreenApp extends StatelessWidget {
  const MainScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    return FlutterWebFrame(
      maximumSize: kIsWeb ? const Size.fromWidth(800) : const Size.fromWidth(400),
      backgroundColor: isDark ? Colors.black12 : Colors.grey[200],
      enabled: kIsWeb || !Platform.isAndroid && !Platform.isIOS,
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          color: Colors.white,
          title: 'MAYA TECH EXAM (JG)',
          theme: Themings.lightTheme,
          navigatorKey: AppNavigator.navigatorKey,
          onGenerateRoute: AppNavigator.onGenerateRoute,
          builder: (context, child) {
            if (child == null) return const SizedBox.shrink();

            final data = MediaQuery.of(context);

            return MediaQuery(
              data: data.copyWith(
                textScaler: TextScaler.linear(1),
              ),
              child: child,
            );
          },
        );
      },
    );
  }
}
