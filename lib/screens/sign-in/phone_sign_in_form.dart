import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/common-widgets/form_submit_button.dart';
import 'package:keep_track_toolkit/common-widgets/show_alert_dialog.dart';
import 'package:keep_track_toolkit/common-widgets/show_exception_alert_dialog.dart';
import 'package:keep_track_toolkit/screens/sign-in/phone_sign_in_change_model.dart';
import 'package:keep_track_toolkit/services/auth.dart';
import 'package:keep_track_toolkit/utils/show_snack_bar.dart';
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
  final TextEditingController _phoneNumberController = TextEditingController();

  PhoneSignInChangeModel get model => widget.model;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _submit() async {
    try {
      await model.submit();
      if (!mounted) return;
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: "Sign in failed",
        exception: e,
      );
    }
  }

  Future<void> _confirmResetPassword(BuildContext context, String email) async {
    final didConfirmResetPassword = await showAlertDialog(
      context,
      title: "Reset password confirmation",
      content:
          "Are you sure you want to reset your password?  An email will be sent to $email",
      defaultAction: AlertAction(
        text: "Reset",
        destructive: true,
      ),
      cancelAction: AlertAction(text: "Cancel"),
    );

    if (didConfirmResetPassword == true) {
      _initiatePasswordReset(email);
    }
  }

  Future<void> _initiatePasswordReset(String email) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.resetPassword(email);
      if (!mounted) return;
      showSnackBar(context, "Reset Password email sent!");
    } catch (e) {
      debugPrint("Password reset failed with exception: ${e.toString()}");
    }
  }

  List<Widget> _buildChildren() {
    return [
      _buildPhoneNumberTextField(),
      const SizedBox(height: 16),
      FormSubmitButton(
        newChild: !model.isLoading
            ? const Text(
                "Sign in",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              )
            : const CircularProgressIndicator(),
        callback: model.submitEnabled ? _submit : null,
      ),
    ];
  }

  Widget _buildPhoneNumberTextField() {
    return TextField(
      controller: _phoneNumberController,
      decoration: InputDecoration(
        labelText: "Phone Number",
        errorText: model.phoneNumberErrorText,
        enabled: !model.isLoading,
      ),
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: model.updatePhoneNumber,
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
