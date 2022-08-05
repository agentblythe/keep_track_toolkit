import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/common-widgets/show_alert_dialog.dart';

Future<void> showExceptionAlertDialog(
  BuildContext context, {
  required String title,
  required Exception exception,
}) =>
    showAlertDialog(
      context,
      title: title,
      content: _message(exception),
      defaultAction: AlertAction(text: "OK"),
    );

String _message(Exception exception) {
  // if (exception is FirebaseException) {
  //   return exception.message ?? "Unknown Firebase Exception";
  // }
  return exception.toString();
}
