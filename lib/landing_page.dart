import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/screens/sign-in/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInPage.create(context);
  }
}
