import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ProfileChangeModel>(
      create: (_) => ProfileChangeModel(user: auth.currentUser!),
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
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User?>(
      builder: (context, snapshot) {
        return ChangeNotifierProvider<ProfileChangeModel>(
          create: (_) => ProfileChangeModel(user: auth.currentUser!),
          child: Consumer<ProfileChangeModel>(
            builder: (_, model, __) => _buildProfilePageForm(model),
          ),
        );
      },
      stream: auth.userChanges(),
    );
  }

  Widget _buildProfilePageForm(ProfileChangeModel model) {
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
      _buildDisplayNameTextField(),
      const SizedBox(height: 16),
      const FormSubmitButton(
        newChild: Text(
          "Save Changes",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        callback: null,
      ),
    ];
  }

  Widget _buildDisplayNameTextField() {
    return TextFormField(
      initialValue: widget.model.displayName,
      decoration: InputDecoration(
        labelText: "Display Name",
        hintText: "Joe Bloggs",
        //errorText: model.emailErrorText,
        //enabled: !model.isLoading,
      ),
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      //focusNode: _emailFocusNode,
      //onEditingComplete: () => _emailEditingComplete(),
      onChanged: (newDisplayName) {},
    );
  }
}