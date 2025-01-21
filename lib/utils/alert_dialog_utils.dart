import 'package:flutter/material.dart';

class AlertDialogUtils {

  static showAlertDialog({
    required BuildContext context,
    String title = 'Status',
    required String contentText,
    required String buttonText,
    required void Function()? onButtonPressed,
  })
  {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(contentText),
      actions: [
        TextButton(
          onPressed: onButtonPressed,
          child: Text(buttonText),
        ),
      ],
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showLoadingAlertDialog({required BuildContext context}){
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 5),
              child:const Text("Loading")
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  static hideAlertDialog({required BuildContext context}) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }

}