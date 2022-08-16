import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keep_track_toolkit/common-widgets/form_submit_button.dart';
import 'package:keep_track_toolkit/screens/profile/profile_change_model.dart';
import 'package:keep_track_toolkit/services/auth.dart';
import 'package:provider/provider.dart';

class ProfilePageForm extends StatefulWidget {
  final ProfileChangeModel model;

  const ProfilePageForm({
    Key? key,
    required this.model,
  }) : super(key: key);

  static Widget create(BuildContext context) {
    AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    User user = auth.currentUser!;
    return ChangeNotifierProvider<ProfileChangeModel>(
      create: (_) => ProfileChangeModel(user: user),
      child: Consumer<ProfileChangeModel>(
        builder: (_, model, __) => ProfilePageForm(
          model: model,
        ),
      ),
    );
  }

  @override
  State<ProfilePageForm> createState() => _ProfilePageFormState();
}

class _ProfilePageFormState extends State<ProfilePageForm> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final FocusNode _displayNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  void initState() {
    _displayNameController.text = widget.model.displayName ?? "";
    _emailController.text = widget.model.email ?? "";
    _phoneController.text = widget.model.phone ?? "";

    super.initState();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();

    _displayNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();

    super.dispose();
  }

  void _submitForm() {}

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

  List<Widget> _buildChildren() {
    return [
      _buildProfilePhoto(),
      const SizedBox(height: 8),
      _buildDisplayNameTextField(),
      const SizedBox(height: 8),
      _buildEmailTextField(),
      const SizedBox(height: 8),
      _buildPhoneTextField(),
      const SizedBox(height: 16),
      _buildFormSubmitButton(),
    ];
  }

  Widget _buildProfilePhoto() {
    String? photoURL = widget.model.photoURL;
    return IconButton(
      iconSize: 75,
      onPressed: () {},
      icon: CircleAvatar(
        radius: 50,
        child: photoURL == null
            ? const Icon(FontAwesomeIcons.camera)
            : Image.network(
                photoURL,
                loadingBuilder: (context, child, loadingProgress) {
                  return const CircularProgressIndicator();
                },
              ),
      ),
    );
  }

  Widget _buildDisplayNameTextField() {
    return TextFormField(
      controller: _displayNameController,
      focusNode: _displayNameFocusNode,
      decoration: const InputDecoration(
        labelText: "Display Name",
        hintText: "Joe Bloggs",
      ),
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      enableSuggestions: false,
      textInputAction: TextInputAction.next,
      onChanged: (displayName) {
        widget.model.updateWith(displayName: displayName);
      },
      onEditingComplete: () {
        FocusNode newFocus = _emailFocusNode;
        FocusScope.of(context).requestFocus(newFocus);
      },
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "joe.bloggs@email.com",
        errorText: widget.model.emailErrorText,
      ),
      keyboardType: TextInputType.emailAddress,
      enableSuggestions: false,
      onChanged: (email) {
        widget.model.updateWith(email: email);
      },
      onEditingComplete: () {},
    );
  }

  Widget _buildPhoneTextField() {
    return TextFormField(
      controller: _phoneController,
      focusNode: _phoneFocusNode,
      decoration: InputDecoration(
        labelText: "Phone",
        hintText: "+441234567890",
        errorText: widget.model.phoneErrorText,
      ),
      keyboardType: TextInputType.phone,
      enableSuggestions: false,
      onChanged: (phone) {
        widget.model.updateWith(phone: phone);
      },
      onEditingComplete: () {},
      enabled: false,
    );
  }

  Widget _buildFormSubmitButton() {
    return FormSubmitButton(
      newChild: const Text(
        "Submit",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      callback: widget.model.submitEnabled ? _submitForm : null,
    );
  }
}
