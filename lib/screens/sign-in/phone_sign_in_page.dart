import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/screens/sign-in/phone_sign_in_form.dart';

class PhoneSignInPage extends StatelessWidget {
  const PhoneSignInPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: PhoneSignInForm.create(context),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
