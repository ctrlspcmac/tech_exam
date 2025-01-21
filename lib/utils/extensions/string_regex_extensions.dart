import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maya_tech_exam/utils/utils.dart';

extension StringRegexExtensions on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidUserName {
    final nameRegExp = RegExp(r"^([A-Za-z]{1,})+([A-Za-z0-9]{5,})$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*]).{8,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = RegExp(r"^([A-Za-z\s]{1,})$");
    return nameRegExp.hasMatch(this);
  }

  String formatAsDecimalWithCommas() {
    try {
      final number = double.parse(this);

      final formatter = NumberFormat('#,##0.00', 'en_US');
      return formatter.format(number);
    } catch (e) {
      return this;
    }
  }

  String removePHPAndParse() {
    String cleanedString = endsWith(' PHP') ? substring(0, length - 4) : this;
    cleanedString = cleanedString.replaceAll(',', '');
    LoggerUtil.info("cleanedString $cleanedString");
    return cleanedString;
  }

  String removePHPAndParseInFront() {
    String cleanedString = startsWith('PHP ') ? substring(4) : this;
    cleanedString = cleanedString.replaceAll(',', '');
    return cleanedString;
  }

  double toDouble() {
    return double.tryParse(removePHPAndParse()) ?? 0.0;
  }

  double toDoubleInFront() {
    return double.tryParse(removePHPAndParseInFront()) ?? 0.0;
  }
}

extension SafeEdgeInsets on EdgeInsets {
  EdgeInsets get safePadding {
    return EdgeInsets.only(
      top: top >= 0 ? top : 0,
      left: left >= 0 ? left : 0,
      right: right >= 0 ? right : 0,
      bottom: bottom >= 0 ? bottom : 0,
    );
  }
}
