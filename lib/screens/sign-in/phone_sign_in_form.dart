import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/common-widgets/form_submit_button.dart';
import 'package:keep_track_toolkit/common-widgets/show_exception_alert_dialog.dart';
import 'package:keep_track_toolkit/screens/sign-in/phone_sign_in_change_model.dart';
import 'package:keep_track_toolkit/services/auth.dart';
import 'package:provider/provider.dart';

class PhoneSignInForm extends StatefulWidget {
  const PhoneSignInForm({
    Key? key,
    required this.model,
  }) : super(key: key);

  final PhoneSignInChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<PhoneSignInChangeModel>(
      create: (_) => PhoneSignInChangeModel(auth: auth),
      child: Consumer<PhoneSignInChangeModel>(
        builder: (_, model, __) => PhoneSignInForm(
          model: model,
        ),
      ),
    );
  }

  @override
  State<PhoneSignInForm> createState() => _PhoneSignInFormState();
}

class _PhoneSignInFormState extends State<PhoneSignInForm> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  final FocusNode _phoneFocusNode = FocusNode();

  PhoneSignInChangeModel get model => widget.model;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _submit() async {
    try {
      if (model.verificationId == "") {
        await model.verifyPhoneNumber();
      } else {
        await model.submit(
          model.verificationId,
          model.otp,
        );
        if (!mounted) return;
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: "Sign in failed",
        exception: e,
      );
    }
  }

  List<Widget> _buildChildren() {
    return [
      _buildPhoneTextField(),
      const SizedBox(height: 16),
      if (model.verificationId != "") _buildVerifiedContents(),
      FormSubmitButton(
        newChild: !model.isLoading
            ? Text(
                model.buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              )
            : const CircularProgressIndicator(),
        callback: model.submitEnabled ? _submit : null,
      ),
    ];
  }

  Widget _buildPhoneTextField() {
    return TextField(
      controller: _phoneController,
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Include International Code, e.g. +44",
        errorText: model.phoneErrorText,
        enabled: !model.isLoading && model.verificationId == "",
      ),
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      focusNode: _phoneFocusNode,
      onChanged: model.updatePhone,
    );
  }

  Widget _buildVerifiedContents() {
    return Column(
      children: [
        _buildPhoneNumberVerifiedLabel(),
        _buildOTPTextField(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildOTPTextField() {
    return TextField(
      controller: _otpController,
      decoration: InputDecoration(
        labelText: "One Time Passcode",
        hintText: "e.g. 123456",
        enabled: !model.isLoading && model.verificationId != "",
      ),
      keyboardType: TextInputType.number,
      onChanged: model.updateOTP,
    );
  }

  Widget _buildPhoneNumberVerifiedLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Icon(
          Icons.check_circle_rounded,
          color: Colors.green,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Phone Number Verified"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }
}
