import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keep_track_toolkit/common-widgets/form_submit_button.dart';
import 'package:keep_track_toolkit/screens/profile/profile_cubit.dart';
import 'package:keep_track_toolkit/screens/profile/profile_change_model.dart';
import 'package:keep_track_toolkit/services/auth.dart';
import 'package:keep_track_toolkit/utils/show_snack_bar.dart';
import 'package:provider/provider.dart';

class ProfilePageForm extends StatefulWidget {
  final ProfileChangeModel model;
  final AuthBase auth;

  const ProfilePageForm({
    Key? key,
    required this.model,
    required this.auth,
  }) : super(key: key);

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final user = auth.currentUser!;
    return StreamBuilder<User?>(
      stream: auth.userChanges(),
      initialData: user,
      builder: (context, snapshot) {
        return BlocProvider(
          create: (_) => ProfileCubit(
            user: user,
          ),
          child: BlocBuilder<ProfileCubit, ProfileChangeModel>(
            builder: (context, profileChangeModel) {
              return ProfilePageForm(
                model: profileChangeModel,
                auth: auth,
              );
            },
          ),
        );
      },
    );
  }

  @override
  State<ProfilePageForm> createState() => _ProfilePageFormState();
}

class _ProfilePageFormState extends State<ProfilePageForm> {
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
      _buildDisplayNameTextField(),
      const SizedBox(height: 8),
      _buildEmailTextField(),
      const SizedBox(height: 16),
      FormSubmitButton(
        newChild: !widget.model.isLoading
            ? const Text(
                "Save Changes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              )
            : const CircularProgressIndicator(),
        callback: widget.model.submitEnabled ? () => _submit() : null,
      ),
    ];
  }

  Widget _buildDisplayNameTextField() {
    return TextFormField(
      initialValue: widget.model.displayName,
      decoration: InputDecoration(
        labelText: "Display Name",
        hintText: "Joe Bloggs",
        enabled: !widget.model.isLoading,
      ),
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      onChanged: (newDisplayName) {
        context
            .read<ProfileCubit>()
            .updateDisplayName(newDisplayName == "" ? null : newDisplayName);
      },
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      initialValue: widget.model.email,
      decoration: InputDecoration(
        labelText:
            "Email${!widget.model.emailEnabled ? " - You can't change this field" : ""}",
        hintText: "joe.bloggs@email.com",
        enabled: widget.model.emailEnabled,
      ),
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      onChanged: (newEmail) {
        context
            .read<ProfileCubit>()
            .updateDisplayName(newEmail == "" ? null : newEmail);
      },
    );
  }

  void _submit() {
    context.read<ProfileCubit>().updateIsLoading(true);
    widget.auth
        .updateDisplayName(widget.model.displayName)
        .then((value) => context.read<ProfileCubit>().updateIsLoading(false))
        .then((value) => showSnackBar(context, "Changes Saved"));
  }
}
