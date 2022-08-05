import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/common-widgets/custom_elevated_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    Key? key,
    required final String text,
    required final Color buttonColor,
    final Color? textColor,
    final VoidCallback? onPressed,
  }) : super(
          key: key,
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 15.0,
            ),
          ),
          buttonColor: buttonColor,
          onPressed: onPressed,
        );
}
