import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/screens/sign-in/sign_in_button_with_text_and_icon.dart';

class SignInPage extends StatelessWidget {
  //final bool isLoading;

  const SignInPage({
    Key? key,
    //required this.isLoading,
  }) : super(key: key);

  static Widget create(BuildContext context) {
    // return ChangeNotifierProvider<ValueNotifier<bool>>(
    //   create: (_) => ValueNotifier<bool>(false),
    //   child: Consumer<ValueNotifier<bool>>(
    //     builder: (_, isLoading, __) => Provider<SignInManager>(
    //       create: (_) => SignInManager(
    //         auth: auth,
    //         isLoading: isLoading,
    //       ),
    //       child: Consumer<SignInManager>(
    //         builder: (_, bloc, __) => SignInPage(
    //           manager: bloc,
    //           isLoading: isLoading.value,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return SignInPage();
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
    // if (exception is FirebaseException &&
    //     exception.code == "SIGN_IN_ABORTED_BY_USER") {
    //   return;
    // }
    // showExceptionAlertDialog(
    //   context,
    //   title: "Sign in failed",
    //   exception: exception,
    // );
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    // try {
    //   await manager.signInWithGoogle();
    // } on Exception catch (e) {
    //   _showSignInError(context, e);
    // }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    // try {
    //   await manager.signInWithFacebook();
    // } on Exception catch (e) {
    //   _showSignInError(context, e);
    // }
  }

  void _signInWithEmail(BuildContext context) {
    // Navigator.of(context).push(
    //   MaterialPageRoute<void>(
    //     fullscreenDialog: true,
    //     builder: (context) => const EmailSignInPage(),
    //   ),
    // );
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
            image: "images/google-logo.png",
            text: "Sign in with Google",
            buttonColor: Colors.white,
            textColor: Colors.black87,
            onPressed:
                () {}, // isLoading ? null : () => _signInWithGoogle(context),
          ),
          const SizedBox(
            height: 8,
          ),
          SignInButtonWithTextAndIcon(
            image: "images/facebook-logo.png",
            text: "Sign in with Facebook",
            buttonColor: const Color(0xFF334D92),
            textColor: Colors.white,
            onPressed:
                () {}, // isLoading ? null : () => _signInWithFacebook(context),
          ),
          const SizedBox(
            height: 8,
          ),
          SignInButtonWithTextAndIcon(
            image: "images/email-icon.png",
            text: "Sign in with Email",
            buttonColor: Colors.teal.shade700,
            textColor: Colors.white,
            onPressed:
                () {}, // isLoading ? null : () => _signInWithEmail(context),
          ),
          const SizedBox(
            height: 8,
          ),
          SignInButtonWithTextAndIcon(
            image: "images/phone-icon.png",
            text: "Sign in with Phone",
            buttonColor: Colors.yellow.shade300,
            textColor: Colors.black,
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    // if (isLoading) {
    //   return const Center(child: CircularProgressIndicator());
    // } else {
    return const Text(
      "Sign in",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
  //}
}
