import 'package:flutter/material.dart';

showErrorAlertDialog(BuildContext context, String error, Function()? onPressed) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: onPressed,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text(error),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}