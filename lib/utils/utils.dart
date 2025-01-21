import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message,
      {Color backgroundColor = Colors.black,
        Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
}

class LoggerUtil {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(methodCount: 1),
  );

  LoggerUtil._();

  static Logger get instance => _logger;

  static void debug(String message) {
    _logger.d(message);
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void warn(String message) {
    _logger.w(message);
  }

  static void error(String message) {
    _logger.e(message);
  }
}


