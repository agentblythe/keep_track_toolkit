import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keep_track_toolkit/common-widgets/show_exception_alert_dialog.dart';
import 'package:keep_track_toolkit/screens/sign-in/email_sign_in_page.dart';
import 'package:keep_track_toolkit/screens/sign-in/phone_sign_in_page.dart';
import 'package:keep_track_toolkit/screens/sign-in/sign_in_button_with_text_and_icon.dart';
import 'package:keep_track_toolkit/screens/sign-in/sign_in_manager.dart';
import 'package:keep_track_toolkit/services/auth.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final SignInManager manager;
  final bool isLoading;

  const SignInPage({
    Key? key,
    required this.manager,
    required this.isLoading,
  }) : super(key: key);

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(
            auth: auth,
            isLoading: isLoading,
          ),
          child: Consumer<SignInManager>(
            builder: (_, bloc, __) => SignInPage(
              manager: bloc,
              isLoading: isLoading.value,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keep Track Toolkit'),
        elevation: 2.0,
      ),
      body: _buildContent(
        context,
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == "SIGN_IN_ABORTED_BY_USER") {
      return;
    }
    showExceptionAlertDialog(
      context,
      title: "Sign in failed",
      exception: exception,
    );
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await manager.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithTwitter(BuildContext context) async {
    try {
      await manager.signInWithTwitter();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => const EmailSignInPage(),
      ),
    );
  }

  void _signInWithPhone(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => const PhoneSignInPage(),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 50.0,
            child: _buildHeader(),
          ),
          const SizedBox(
            height: 48,
          ),
          SignInButtonWithTextAndIcon(
            iconData: FontAwesomeIcons.google,
            text: "Sign in with Google",
            buttonColor: Colors.white,
            textColor: Colors.black87,
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
          ),
          const SizedBox(
            height: 8,
          ),
          SignInButtonWithTextAndIcon(
            iconData: FontAwesomeIcons.facebook,
            text: "Sign in with Facebook",
            buttonColor: const Color(0xFF334D92),
            textColor: Colors.white,
            onPressed: isLoading ? null : () => _signInWithFacebook(context),
          ),
          const SizedBox(
            height: 8,
          ),
          SignInButtonWithTextAndIcon(
            iconData: FontAwesomeIcons.twitter,
            text: "Sign in with Twitter",
            buttonColor: Colors.white,
            textColor: Colors.black,
            iconColor: const Color(0xFF1DA1F2),
            onPressed: isLoading ? null : () => _signInWithTwitter(context),
          ),
          const SizedBox(
            height: 8,
          ),
          SignInButtonWithTextAndIcon(
            iconData: FontAwesomeIcons.envelope,
            text: "Sign in with Email",
            buttonColor: Colors.teal.shade700,
            textColor: Colors.white,
            onPressed: isLoading ? null : () => _signInWithEmail(context),
          ),
          const SizedBox(
            height: 8,
          ),
          SignInButtonWithTextAndIcon(
            iconData: FontAwesomeIcons.phone,
            text: "Sign in with Phone",
            buttonColor: Colors.amber.shade200,
            textColor: Colors.black,
            onPressed: isLoading ? null : () => _signInWithPhone(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return const Text(
        "Sign in",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }
}
