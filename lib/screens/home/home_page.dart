import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keep_track_toolkit/navigation/app_routes.dart';
import 'package:keep_track_toolkit/profile/profile_manager.dart';
import 'package:keep_track_toolkit/screens/profile/profile_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileManager = Provider.of<ProfileManager>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keep Track Toolkit'),
        leading: _buildUserProfileButton(
          profileManager.appUser,
          context,
        ),
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
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }

  Widget _buildUserProfileButton(User appUser, BuildContext context) {
    return IconButton(
      icon: appUser.photoURL == null
          ? const Icon(FontAwesomeIcons.user)
          : Image.network(appUser.photoURL!),
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.routeProfile);
      },
    );
  }
}
