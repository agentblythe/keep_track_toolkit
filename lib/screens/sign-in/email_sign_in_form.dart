import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/common-widgets/form_submit_button.dart';
import 'package:keep_track_toolkit/common-widgets/show_alert_dialog.dart';
import 'package:keep_track_toolkit/common-widgets/show_exception_alert_dialog.dart';
import 'package:keep_track_toolkit/screens/sign-in/email_sign_in_change_model.dart';
import 'package:keep_track_toolkit/services/auth.dart';
import 'package:keep_track_toolkit/utils/show_snack_bar.dart';
import 'package:provider/provider.dart';

class EmailSignInForm extends StatefulWidget {
  const EmailSignInForm({
    Key? key,
    required this.model,
  }) : super(key: key);

  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (_, model, __) => EmailSignInForm(
          model: model,
        ),
      ),
    );
  }

  @override
  State<EmailSignInForm> createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  EmailSignInChangeModel get model => widget.model;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() async {
    try {
      await model.submit();
      popNavigationContext();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: "Sign in failed",
        exception: e,
      );
    }
  }

  void popNavigationContext() {
    Navigator.of(context).pop();
  }

  void _toggleFormType() {
    model.toggleFormType();

    _emailController.clear();
    _passwordController.clear();
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
      _buildEmailTextField(),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPasswordTextField(),
          _passwordVisibilityIcon(),
        ],
      ),
      const SizedBox(height: 16),
      FormSubmitButton(
        newChild: !model.isLoading
            ? Text(
                model.primaryButtonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              )
            : const CircularProgressIndicator(),
        callback: model.submitEnabled ? _submit : null,
      ),
      const SizedBox(height: 8),
      TextButton(
        onPressed: !model.isLoading ? _toggleFormType : null,
        child: Text(model.secondaryButtonText),
      ),
      if (model.formType == EmailSignInFormType.signIn)
        TextButton(
          onPressed: model.restPasswordEnabled
              ? () => _confirmResetPassword(context, model.email)
              : null,
          child: const Text("Forgotten your password? Reset it."),
        ),
    ];
  }

  Widget _passwordVisibilityIcon() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: IconButton(
        onPressed: model.togglePasswordVisibility,
        icon: const Icon(
          Icons.remove_red_eye,
        ),
        color: model.hidePassword ? Colors.grey : Colors.blue,
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "test@test.com",
        errorText: model.emailErrorText,
        enabled: !model.isLoading,
      ),
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      onEditingComplete: () => _emailEditingComplete(),
      onChanged: model.updateEmail,
    );
  }

  Widget _buildPasswordTextField() {
    return Expanded(
      child: TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: "Password",
          errorText: model.passwordErrorText,
          enabled: !model.isLoading,
        ),
        obscureText: model.hidePassword,
        textInputAction: TextInputAction.done,
        focusNode: _passwordFocusNode,
        onEditingComplete: model.submitEnabled ? _submit : null,
        onChanged: model.updatePassword,
      ),
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

  void _emailEditingComplete() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }
}
