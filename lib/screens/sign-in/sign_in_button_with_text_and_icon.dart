import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keep_track_toolkit/common-widgets/custom_elevated_button.dart';

class SignInButtonWithTextAndIcon extends CustomElevatedButton {
  SignInButtonWithTextAndIcon({
    Key? key,
    required final IconData iconData,
    //required final String image,
    required final String text,
    required final Color buttonColor,
    required final Color textColor,
    final Color? iconColor,
    final VoidCallback? onPressed,
  }) : super(
          key: key,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FaIcon(
                iconData,
                color: iconColor ?? textColor,
              ),
              //Image.asset(image),
              Text(
                text,
                style: TextStyle(
                  color: onPressed == null ? Colors.white : textColor,
                  fontSize: 15.0,
                ),
              ),
              Opacity(
                opacity: 0.0,
                child: FaIcon(iconData), //Image.asset(image),
              )
            ],
          ),
          buttonColor: onPressed == null ? Colors.grey : buttonColor,
          onPressed: onPressed,
        );
}
