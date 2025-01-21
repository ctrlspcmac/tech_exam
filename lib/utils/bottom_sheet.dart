import 'dart:math';
import 'package:flutter/material.dart';
import 'package:maya_tech_exam/utils/extensions/string_regex_extensions.dart';

class BottomSheetUtils {
  static void showCustomBottomSheet({
    required BuildContext context,
    required Widget child,
    double height = 500,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final maxHeight = screenHeight * 0.4;

        final finalHeight = (height.isNaN || height <= 0) ? maxHeight : min(height, maxHeight);

        return Container(
          height: finalHeight,
          width: double.infinity,
          padding: EdgeInsets.all(16.0).safePadding,
          child: SingleChildScrollView(
            child: child,
          ),
        );
      },
    );
  }
}
