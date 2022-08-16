import 'package:flutter/material.dart';
import 'package:keep_track_toolkit/profile/profile_manager.dart';
import 'package:keep_track_toolkit/screens/profile/profile_page_form.dart';
import 'package:keep_track_toolkit/services/auth.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileManager = Provider.of<ProfileManager>(context, listen: true);
    var auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        elevation: 2.0,
        actions: <Widget>[
          Switch(
            activeThumbImage: Image.asset("images/dark.png").image,
            value: profileManager.darkMode,
            onChanged: (darkMode) {
              profileManager.darkMode = darkMode;
            },
            inactiveThumbImage: Image.asset("images/light.png").image,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: ProfilePageForm.create(context),
          ),
        ),
      ),
    );
  }
}
